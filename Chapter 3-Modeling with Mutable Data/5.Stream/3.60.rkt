(load "3.50.rkt")

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s n)
  (stream-map (lambda (x) (* x n)) s))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series (stream-cdr s1) s2))))

(load "3.59.rkt")
(define t (add-streams (mul-series sine-series sine-series)
                       (mul-series cosine-series cosine-series)))