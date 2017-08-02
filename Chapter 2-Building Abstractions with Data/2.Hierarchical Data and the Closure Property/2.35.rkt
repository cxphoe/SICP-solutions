(load "sequence_operation.rkt")

(define x (list (list 1 (list 2 3)) (list 4 5)))
(define y (list 1 (list 2 3 (list 4)) (list 5 6) 7))

(define (count-leaves t)
  (accumulate (lambda (first-node already-done)
                (+ (if (pair? first-node)
                       (count-leaves first-node)
                       1)
                   already-done))
              0
              t))

(define (count-leaves-1 t)
  (accumulate +
              0
              (map (lambda (node)
                     (if (pair? node)
                         (count-leaves-1 node)
                         1))
                    t)))

(define (count-leaves-2 t)
  (accumulate (lambda (x y) (+ 1 y))
              0
              (enumerate-tree t)))