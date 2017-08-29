(load "evaluator.rkt")
(load "environment.rkt")

(define input-prompt ";;; L-Eval input:")
(define output-prompt ";;; L-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object))))
        ((lazy-pair? object)
         (print-lazy-pair object the-global-environment))
        (else (display object))))

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))

(load "lazy-list-environment.rkt")

;(eval '(define (factorial n) (if (= n 1) 1 (* (factorial (- n 1)) n))) the-global-environment)
;(eval '(define (test n) (define t1 (runtime)) (define res (factorial n)) (define t2 (runtime)) (- t2 t1)) the-global-environment)

(driver-loop)

;(define (f x) (define (even? n) (if (= n 0) true (odd? (- n 1)))) (define (odd? n) (if (= n 0) false (even? (- n 1)))) (even? x))