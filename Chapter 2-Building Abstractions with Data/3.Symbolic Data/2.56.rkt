(load "derivation.rkt")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((exponentiation? exp)
         (let ((base (base exp))
               (e (exponent exp)))
           (make-product (make-product e
                                       (make-exponentiation base
                                                            (make-sum e -1)))
                         (deriv b var))))))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (make-exponentiation b e)
  (cond ((=number? b 1) 1)
        ((=number? e 0) 1)
        ((=number? e 1) b)
        (else (list '** b e))))

(define (base e) (cadr e))

(define (exponent e) (caddr e))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))