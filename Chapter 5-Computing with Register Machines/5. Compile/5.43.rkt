; SICP exercise 5.43
;
; Interval definition:
; Because there could be any definition that might extend the frame during
; the run time if we just treat it like the normal definition, which will
; change the exact lexical addres of the existed vars, because we find
; lexical address of a var just based on lambda parameters.
; scan-out-defines from ex-4.16 will certainly help erase this issue.

; my implementation of scan-out-defines from ex-4.16
(define (scan-out-defines procedure-body)
  (define (iter body res1 res2)
    (cond ((null? body)
           (cons res1 res2))
          ((definition? (car body))
           (iter (cdr body) res1 (cons (car body) res2)))
          (else
           (iter (cdr body) (cons (car body) res1) res2))))
  (let ((sepa (iter procedure-body '() '())))
    (let ((body (car sepa)) (defines (cdr sepa)))
      (if (null? defines)
          procedure-body
          (let ((define-vars (map definition-variable defines))
                (define-vals (map definition-value defines)))
            (list (make-let (map (lambda (var) (list var ''*unassigned*))
                                 define-vars)
                            (append (map (lambda (var val)
                                           (list 'set! var val))
                                         define-vars
                                         define-vals)
                                    body))))))))

; and change the return result of compile-lambda-body
(define (compile-lambda-body exp proc-entry compile-env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence (scan-out-defines (lambda-body exp))
                       'val 'return
                       (cons formals compile-env)))))