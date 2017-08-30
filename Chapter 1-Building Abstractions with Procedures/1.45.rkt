(load "fixed_point.rkt")
(load "1.43.rkt")

(define (average-damp f)
  (lambda (x)
    (/ (+ x (f x)) 2)))

(define (n-th-power x n)
  (if (= n 1)
      x
      (* x (n-th-power x (- n 1)))))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (root x n times)
  (fixed-point-of-transform (lambda (y) (/ x (n-th-power y (- n 1))))
                            (repeated average-damp times)
                            1.0))

;(root 100 2 1)
;(root 100 3 1)
;(root 100 4 2)
;(root 100 5 2)
;(root 100 6 1)
;(root 100 7 1)
;(root 100 8 1)
;(root 100 13 3)