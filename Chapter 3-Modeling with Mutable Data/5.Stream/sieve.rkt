(load "stream.rkt")

(define (sieve stream)
  (cons-stream
   (stream-car stream)
   (sieve (stream-filter
           (lambda (x)
             (nor (divisible? x (stream-car stream))))
           (stream-cdr stream)))))