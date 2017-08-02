(load "3.50.rkt")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s n)
  (stream-map (lambda (x) (* x n)) s))

(define (integars-starting-from n)
  (cons-stream n (integars-starting-from (+ n 1))))

(define factorials (cons-stream 1 (mul-streams factorials
                                               (integars-starting-from 2))))