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

(define (env-loop var-not-in-frame proc env var)
  (define (scan frame)
    (define (iter vars vals)
      (cond ((null? vars) (var-not-in-frame))
            ((eq? var (car vars)) (proc vals))
            (else
             (iter (cdr vars) (cdr vals)))))
    (iter (frame-variables frame) (frame-values frame)))
  
  (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (or (scan frame)
            (env-loop var-not-in-frame proc (enclosing-environment env) var)))))

(define (lookup-variable-value var env)
  (define (var-not-in-frame) false)
  (env-loop var-not-in-frame car env var))

(define (set-variable-value! var val env)
  (define (var-not-in-frame) false)
  (env-loop var-not-in-frame (lambda (x) (set-car! x val)) env var))

(define (define-variable! var val env)
  (define (var-not-in-frame)
    (add-binding-to-frame! var val (first-frame env)))
  (env-loop var-not-in-frame (lambda (x) (set-car! x val)) env var))