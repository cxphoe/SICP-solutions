(load "connector.rkt")

(define (averager a b c)
  (let ((u (make-connector))
        (v (make-connector)))
    (adder a b u)
    (multiplier c v u)
    (constant 2 v)
    'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)
(probe 'a a)
(probe 'b b)
(probe 'c c)

(set-value! a 19 'user)
(set-value! b 29 'user)

(forget-value! a 'user)
(set-value! c 10 'user)