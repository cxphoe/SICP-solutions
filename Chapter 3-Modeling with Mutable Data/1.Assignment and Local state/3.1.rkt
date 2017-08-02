(define (make-accumulator init)
  (lambda (amount)
    (if (number? amount)
        (begin (set! init (+ init amount))
               init)
        "improper data type")))

(define A (make-accumulator 5))

(A 10)
(A 10)