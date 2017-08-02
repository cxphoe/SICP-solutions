;; a)
;; What would be delayed are the arguments that the some function apply
;; to. If a function call is delayed, it will still be forced when it's
;; needed, so the sequence inside of it will be executed.

;; b)
(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))
;; the (set! x (cons x '(2))) will be delayed, and it's not needed inside
;; of p. So it won't be executed to change the value of x.

;; c)
;; Cy's solution seems to work on condition that there are inside function
;; calls and some passings of compound arguments that will affect the
;; value of ohter arguments are not the last exp of sequence.

;; d)