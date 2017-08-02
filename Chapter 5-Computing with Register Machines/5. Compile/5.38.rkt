(load "compile-sequence.rkt")

(define (over-write? op compile-env)
  (eq? (find-variable op compile-env)
       'not-found))

(define (open-code? exp compile-env)
  (and (pair? exp)
       (memq (car exp) open-operator)
       (over-write? (car exp) compile-env)))

(define open-operator '(= - + *))

;; a)
(define (spread-arguments operands compile-env)
  (let ((arg1-code (compile (car operands) 'arg1 'next compile-env))
        (arg2-code (compile (cadr operands) 'arg2 'next compile-env)))
    (list arg1-code arg2-code)))
         
;; b)
(define (compile-open-code op operands target linkage compile-env)
  (cond ((eq? op '=)
         (general-compile '= operands target linkage compile-env))
        ((eq? op '-)
         (general-compile '- operands target linkage compile-env))
        ((eq? op '+)
         (general-compile '+
                          (construct-operands '+ operands)
                          target linkage compile-env))
        ((eq? op '*)
         (general-compile '*
                          (construct-operands '* operands)
                          target linkage compile-env))))

(define (general-compile op operands target linkage compile-env)
  (let ((operand-codes (spread-arguments operands compile-env)))
    (end-with-linkage
     linkage
     (preserving '(env)
                 (car operand-codes)
                 (preserving '(arg1)
                             (cadr operand-codes)
                             (make-instruction-sequence
                              '(arg1 arg2)
                              (list target)
                              (list (list 'assign
                                          target
                                          (list 'op op)
                                          '(reg arg1)
                                          '(reg arg2)))))))))

(define (construct-operands op operands)
  (if (= 2 (length operands))
      operands
      (construct-operands op
                          (cons (list op
                                      (car operands)
                                      (cadr operands))
                                (cddr operands)))))
