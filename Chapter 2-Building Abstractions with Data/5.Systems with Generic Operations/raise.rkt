(load "GAOs.rkt")

(define (install-raise-package)
  (put 'raise 'integar
       (lambda (x) (make-rational x 1)))
  (put 'raise 'rational
       (lambda (r)
         (let ((n (numer r)) (d (denom r)))
           (make-real (if (and (number? n) (number? d))
                          (/ (/ n 1.0) d)
                          (div n d))))))
  (put 'raise 'real
       (lambda (r)
         (make-from-real-imag r 0)))
  'done)

(define (raise x)
  ((get 'raise (type-tag x)) (contents x)))