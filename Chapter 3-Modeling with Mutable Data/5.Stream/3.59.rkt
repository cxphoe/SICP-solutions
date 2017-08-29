(load "3.54.rkt")

;;a)
(define integars
  (cons-stream 1 (stream-map (lambda (x) (+ x 1)) integars)))

(define (integrate-series s)
  (mul-streams (stream-map (lambda (x) (/ 1 x))
                           integars)
               s))

;;b)
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (integrate-series sine-series)))

(define sine-series
  (cons-stream 0 (integrate-series (stream-map - cosine-series))))