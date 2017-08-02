(define (make-segment start-vect end-vect)
  (cons start-vect end-vect))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))