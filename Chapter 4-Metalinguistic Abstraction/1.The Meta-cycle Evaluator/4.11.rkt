; environment operations
(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame var-val-pairs)
  (cons '*table* (var-val-pairs)))

(define (frame-pairs frame) (cdr frame))

(define (first-pair frame) (car (frame-pairs frame)))
(define (rest-pairs frame) (cdr (frame-pairs frame)))

(define (add-binding-to-frame! var-val frame)
  (set-cdr! frame (cons var-val
                        (frame-pairs frame))))

(define (extend-environment var-val-pairs base-env)
  (cons (make-frame var-val-pairs) base-env))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (first-pair frame)))
             (cdr (first-pair frame)))
            (else (scan (rest-pairs frame)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan frame))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (first-pair frame)))
             (set-cdr! (first-pair frame) val))
            (else (scan (rest-pairs frame)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan frame))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan frame)
      (cond ((null? frame)
             (add-binding-to-frame! (cons var val) frame))
            ((eq? var (car (first-pair frame)))
             (set-cdr! (first-pair frame) val))
            (else (scan (rest-pairs frame)))))
    (scan frame)))