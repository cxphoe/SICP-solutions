(load "2.12.rkt")

;assume that the bounds are all positive
;and percent of two cons is small enough
(define (mul-percent x y)
  (+ (percent x) (percent y)))