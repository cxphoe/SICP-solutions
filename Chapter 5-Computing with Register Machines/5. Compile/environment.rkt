(load "expression.rkt")

; environment operations
(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (env-loop env var var-not-in-frame proc)
  (define (scan vars vals)
    (cond ((null? vars) (var-not-in-frame env))
          ((eq? var (car vars)) (proc vals))
          (else
           (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))

(define (lookup-variable-value var env)
  (define (var-not-in-frame env)
    (lookup-variable-value var (enclosing-environment env)))
  (env-loop env var var-not-in-frame car))

(define (set-val! val)
  (lambda (vals) (set-car! vals val)))

(define (set-variable-value! var val env)
  (define (var-not-in-frame env)
    (set-variable-value! var val (enclosing-environment env)))
  (env-loop env var var-not-in-frame (set-val! val)))

(define (define-variable! var val env)
  (define (var-not-in-frame env)
    (add-binding-to-frame! var val (first-frame env)))
  (env-loop env var var-not-in-frame (set-val! val)))