
(load "expression.rkt")
(load "make-label.rkt")
(load "compile-sequence.rkt")
(load "compile-lambda.rkt")
(load "compile-application.rkt")
(load "5.38.rkt")
(load "lexical-address.rkt")

(define (test exp)
  (for-each (lambda (x)
              (if (pair? x) (display "  "))
              (display x)
              (newline))
            (caddr (compile exp 'val 'return '()))))

(define (compile exp target linkage compile-env)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage compile-env))
        ((assignment? exp)
         (compile-assignment exp target linkage compile-env))
        ((definition? exp)
         (compile-definition exp target linkage compile-env))
        ((if? exp) (compile-if exp target linkage compile-env))
        ((lambda? exp) (compile-lambda exp target linkage compile-env))
        ((begin? exp) (compile-sequence (begin-actions exp)
                                        target
                                        linkage
                                        compile-env))
        ((cond? exp) (compile (cond->if exp) target linkage compile-env))
        ((let? exp) (compile (let->combination exp)
                             target linkage compile-env))
        ((open-code? exp compile-env)
         (compile-open-code (operator exp)
                            (operands exp)
                            target linkage compile-env))
        ((application? exp)
         (compile-application exp target linkage compile-env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

(define (compile-linkage linkage)
  (cond ((eq? linkage 'return)
         (make-instruction-sequence '(continue) '()
                                    '((goto (reg continue)))))
        ((eq? linkage 'next)
         (empty-instruction-sequence))
        (else
         (make-instruction-sequence '() '()
                                    (list (list 'goto
                                                (list 'label
                                                      linkage)))))))

(define (end-with-linkage linkage instruction-sequence)
  (preserving '(continue)
              instruction-sequence
              (compile-linkage linkage)))

(define (compile-self-evaluating exp target linkage)
  (end-with-linkage linkage
                    (make-instruction-sequence
                     '() (list target)
                     (list (list 'assign
                                 target
                                 (list 'const exp))))))

(define (compile-quoted exp target linkage)
  (end-with-linkage linkage
                    (make-instruction-sequence
                     '() (list target)
                     (list (list 'assign
                                 target
                                 (list 'const (text-of-quotation exp)))))))

(define (compile-variable exp target linkage compile-env)
  (let ((address (find-variable exp compile-env)))
    (end-with-linkage linkage
                      (make-instruction-sequence
                       '(env) (list target)
                       (if (eq? address 'not-found)
                           (list (list 'assign
                                       target
                                       '(op lookup-variable-value)
                                       (list 'const exp)
                                       '(reg env)))
                           (list (list 'assign
                                       target
                                       '(op lexical-address-lookup)
                                       (list 'const address)
                                       '(reg env))))))))

(define (compile-assignment exp target linkage compile-env)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next compile-env)))
    (let ((address (find-variable var compile-env)))
      (end-with-linkage
       linkage
       (preserving '(env)
                   get-value-code
                   (make-instruction-sequence
                    '(env val)
                    (list target)
                    (list (if (eq? address 'not-found)
                              (list (list perform
                                          '(op set-variable-value!)
                                          (list 'const var)
                                          '(reg val)
                                          '(reg env)))
                              (list (list perform
                                          '(op lexical-address-set!)
                                          (list 'const address)
                                          '(reg val)
                                          '(reg env))))
                          (list 'assign target '(const ok)))))))))

(define (compile-definition exp target linkage compile-env)
  (let ((var (definition-variable exp))
        (get-value-code
         (compile (definition-value exp) 'val 'next compile-env)))
    (end-with-linkage
     linkage
     (preserving '(env)
                 get-value-code
                 (make-instruction-sequence
                  '(env val)
                  (list target)
                  (list (list 'perform
                              '(op define-variable!)
                              (list 'const var)
                              '(reg val)
                              '(reg env))
                        (list 'assign target '(const ok))))))))

(define (compile-if exp target linkage compile-env)
  (let ((t-branch (make-label 'true-branch))
        (f-branch (make-label 'false-branch))
        (after-if (make-label 'after-if)))
    (let ((consequent-linkage
           (if (eq? linkage 'next) after-if linkage)))
      (let ((p-code (compile (if-predicate exp) 'val 'next compile-env))
            (c-code (compile (if-consequent exp)
                             target
                             consequent-linkage
                             compile-env))
            (a-code
             (compile (if-alternative exp) target linkage compile-env)))
        (preserving '(env continue)
                    p-code
                    (append-instruction-sequences
                     (make-instruction-sequence
                      '(val)
                      '()
                      (list '(test (op false?) (reg val))
                            (list 'branch (list 'label f-branch))))
                     (parallel-instruction-sequences
                      (append-instruction-sequences t-branch c-code)
                      (append-instruction-sequences f-branch a-code))
                     after-if))))))

(define (compile-sequence seq target linkage compile-env)
  (if (last-exp? seq)
      (compile (first-exp seq) target linkage compile-env)
      (preserving '(env continue)
                  (compile (first-exp seq) target 'next compile-env)
                  (compile-sequence (rest-exps seq) target linkage compile-env))))
