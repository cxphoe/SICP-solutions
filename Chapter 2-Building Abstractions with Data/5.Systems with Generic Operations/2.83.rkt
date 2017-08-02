(define (install-real-number-package)
  (define (tag x)
    (attach-tag 'real-number x))
  (put 'add '(real-number real-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(real-number real-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(real-number real-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(real-number real-number)
       (lambda (x y) (tag (/ x y))))
  
  (put 'make 'real-number
       (lambda (n) (tag n)))
  'done)

(define (make-real-number n)
  ((get 'make 'real-number) n))

(define (install-raise-package)
  (put 'raise 'scheme-number
       (lambda (x) (make-rational x 1)))
  (put 'raise 'rational
       (lambda (x) (make-real-number (/ (/ (numer x) 1.0)
                                        (denom x)))))
  (put 'raise 'real-number
       (lambda (x) (make-from-real-imag x 0)))
  'done)

(define (raise x)
  ((get 'raise (type-tag x)) (contents x)))