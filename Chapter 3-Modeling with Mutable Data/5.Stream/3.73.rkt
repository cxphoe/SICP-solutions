(load "3.54.rkt")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (lambda (v i)
    (add-streams (scale-stream i R)
                 (integral (scale-stream i (/ 1 C)) v dt))))

(define RC1 (RC 5 1 0.5))