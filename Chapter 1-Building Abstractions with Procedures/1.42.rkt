(define (compose f g)
  (lambda (x)
    (f (g x))))

;((compose (lambda (x) (* x x)) (lambda (x) (+ x 1))) 6)