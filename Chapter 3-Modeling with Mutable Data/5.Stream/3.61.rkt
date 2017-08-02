(load "3.60.rkt")

(define (reciprocal-series s)
  (define series
    (cons-stream 1 (scale-stream (mul-series
                                  (stream-cdr s)
                                  series)
                                 -1)))
  series)