(define (require p)
  (if (not p) (amb)))

(define (an-integar-between low high)
  (require (<= low high))
  (amb low (an-integar-between (+ low 1) high)))