(load "3.54.rkt")

(define ones (cons-stream 1 ones))

(define integars (cons-stream 1 (add-streams ones integars)))

(define (partial-sums s)
  (define ps (add-streams s (cons-stream 0 ps)))
  ps)

(define sum (partial-sums integars))

;(stream-ref sum 4)