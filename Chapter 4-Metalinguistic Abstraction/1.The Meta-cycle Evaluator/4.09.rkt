;;do: (do ((<variable1> <init1> <step1>)
;;         (<variable2> <init2> <step2>)
;;         ...)
;;      (<test> <expression> ...)
;;      <command>)
;;<step>s <expression>s and <command>s can be omitted.
(define (do? exp) (tagged-list? exp 'do))

(define (do-bindings exp) (cadr exp))
(define (do-test exp) (car (caddr exp)))
(define (do-expression exp) (cdr (caddr exp)))
(define (do-command exp) (cdddr exp))

(define (binding-var bind) (car bind))
(define (binding-init bind) (cadr bind))
(define (binding-step bind) (cddr bind))

(define (vars-initial exp)
  (map (lambda (bind)
         (make-definition (binding-var bind) (binding-init bind)))
       (do-bindings exp)))

(define (vars-assignments exp)
  (map (lambda (bind)
         (make-assignment (binding-var bind) (binding-step bind)))
       (filter (lambda (bind)
                 (not (null? (binding-step bind))))
               (do-bindings exp))))

(define (do->if exp)
  (define (iter vars-assigns test command exp)
    (make-if test
             (sequence->exp exp)
             (sequence->exp (cons (sequence->exp command)
                                  (cons (sequence->exp vars-assigns)
                                        (list (iter var-assigns test command exp)))))))
  (sequence->exp (cons (sequence->exp (vars-initial exp))
                       (iter (vars-assignments exp)
                             (do-test exp)
                             (do-command exp)
                             (do-expression exp)))))

;;while: (while <test>
;;         <command>)
(define (while? exp)
  (tagged-list? exp 'while))

(define (while-test exp) (cadr exp))
(define (while-command exp) (cddr exp))

(define (while-iter exp)
  (list 'define '(while-iter)
        (make-if (while-test exp)
                 (sequence->exp (append (while-command exp)
                                        (list '(while-iter))))
                 ''done)))

(define (while->combination exp)
  ; use local definition to avoid name-clash
  (make-application (make-lambda
                     '()
                     (list (sequence->exp
                            (list (while-iter exp)
                                  '(while-iter)))))
                    '()))