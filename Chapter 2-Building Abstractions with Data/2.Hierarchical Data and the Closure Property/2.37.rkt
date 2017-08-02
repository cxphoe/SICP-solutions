(load "2.36.rkt")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (w)
         (dot-product v w))
       m))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (matrix-*-vector cols x))
         m)))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define x (list (list 1 2 3)
                (list 4 5 6)))
(define y (list (list 1 4)
                (list 2 5)
                (list 3 6)))