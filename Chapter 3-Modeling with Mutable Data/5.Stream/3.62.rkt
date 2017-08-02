(load "3.61.rkt")

(define (div-series s1 s2)
  (let ((c (stream-car s2)))
    (if (= c 0)
        (error "cannot divide by zero" s2)
        (mul-series s1
                    (scale-stream (reciprocal-series
                                   (scale-stream s2 (/ 1 c)))
                                  c)))))

(define tan-series
  (div-series sine-series cosine-series))

(define zeros (cons-stream 0 zeros))
(define one (cons-stream 1 zeros))

(define t (div-series one (reciprocal-series cosine-series)))

(define (compare s1 s2)
  (define (helper s1 s2 n)
    (if (> n 0)
        (if (and (= (stream-car s1) (stream-car s2))
                 (helper (stream-cdr s1) (stream-cdr s2) (- n 1)))
            true
            false)))
  (helper s1 s2 10))

(compare t cosine-series)