(define (make-monitored f)
  (let ((times 0))
    (define (how-many-calls?) times)
    (define (mf m)
      (cond ((eq? m 'how-many-calls?) (how-many-calls?))
            ((eq? m 'reset-count) (set! times 0))
            ((number? m) (begin (set! times (+ times 1))
                                (f m)))
            (else
             (error "Unknown request -- MAKE-ACCOUNT" m))))
    mf))

(define s (make-monitored sqrt))

(s 100)
(s 'how-many-calls?)
(s 199)
(s 'reset-count)
(s 'how-many-calls?)