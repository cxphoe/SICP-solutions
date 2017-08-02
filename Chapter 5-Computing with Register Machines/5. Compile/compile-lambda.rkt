(load "compile-sequence.rkt")
(load "scan-out-defines.rkt")

(define (make-compiled-procedure entry env)
  (list 'compiled-procedure entry env))

(define (compiled-procedure? proc)
  (tagged-list? proc 'compiled-procedure))

(define (compiled-procedure-entry c-proc) (cadr c-proc))
(define (compiled-procedure-env c-proc) (caddr c-proc))

(define (compile-lambda exp target linkage compile-env)      ; changed
  (let ((proc-entry (make-label 'entry))
        (after-lambda (make-label 'after-lambda)))
    (let ((lambda-linkage
           (if (eq? linkage 'next) after-lambda linkage)))
      (append-instruction-sequences
       (tack-on-instruction-sequence
        (end-with-linkage
         lambda-linkage
         (make-instruction-sequence
          '(env) (list target)
          (list (list 'assign target
                      '(op make-compiled-procedure)
                      (list 'label proc-entry)
                      '(reg env)))))
        (compile-lambda-body exp proc-entry compile-env))    ; changed
       after-lambda))))

(define (compile-lambda-body exp proc-entry compile-env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence
      '(env proc argl) '(env)
      (list proc-entry
            '(assign env (op compiled-procedure-env) (reg proc))
            (list 'assign 'env
                  '(op extend-environment)
                  (list 'const formals)
                  '(reg argl)
                  '(reg env))))
     (compile-sequence (scan-out-defines (lambda-body exp)) 'val 'return
                       (extend-compile-env formals compile-env))))) ;changed