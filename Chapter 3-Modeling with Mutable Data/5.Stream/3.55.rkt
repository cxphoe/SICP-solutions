(load "3.54.rkt")

(define ones (cons-stream 1 ones))

(define integars (cons-stream 1 (add-streams ones integars)))

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (partial-sums s) (stream-cdr s))))

(define sum (partial-sums integars))

;(stream-ref sum 3)