(define (=zero? x) (apply-generic '=zero? x))

(define (install-=zero?-package)
  (put '=zero? '(scheme-number scheme-number)
       (lambda (x) (= 0 x)))
  (put '=zero? '(rational rational)
       (lambda (x) (= 0 (car x))))
  (put '=zero? '(complex complex)
       (lambda (x) (= 0 (magnitude x)))))