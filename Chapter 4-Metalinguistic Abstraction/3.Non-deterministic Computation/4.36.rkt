(define (require p)
  (if (not p) (amb)))

(define (an-integar-starting-from n)
  (amb n (an-integar-starting-from (+ n 1))))

(define (a-pythagorean-triple)
  (let ((i (an-integar-starting-from 1)))
    (let ((j (an-integar-starting-from i)))
      (let (k (an-integar-starting-from j))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))