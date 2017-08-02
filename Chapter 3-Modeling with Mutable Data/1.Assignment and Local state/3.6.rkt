(define rand
  (let ((x 0))
    (define (generate)
      (begin (set! x (rand-update x))
             x))
    (define (reset new-value)
      (set! x new-value))
    (lambda (m)
      (cond ((eq? m 'geneate) (generate))
            ((eq? m 'reset) (reset))
            (else
             (error "Unknown request -- RAND" m))))))