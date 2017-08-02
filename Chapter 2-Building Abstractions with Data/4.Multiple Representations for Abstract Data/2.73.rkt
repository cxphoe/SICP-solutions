;;original procedures
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;;new
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

;;b)
(define (install-sum-package)
  ;;internal procedures
  (define (addend operands) (car operands))
  (define (augend operands) (cadr operands))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list a1 a2))))
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))

  ;;interface to the rest of system
  (define (tag x)
    (if (pair? x)
        (attach-tag '+ x)
        x))
  (put 'deriv '+ deriv-sum)
  (put 'make 'sum
       (lambda (x y) (tag (make-sum x y)))))

(define (make-sum x y)
  ((get 'make 'sum) x y))

(define (install-product-oackage)
  ;;internal procedures
  (define (multiplier operands) (car operands))
  (define (multiplicand operands) (cadr operands))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 m2))))
  (define (deriv-product operands var)
    (make-sum
     (make-product (multiplier operands)
                   (deriv (multiplicand operands) var))
     (make-product (deriv (multiplier operands) var)
                   (multiplicand operands))))

  ;;interface to the rest of system
  (define (tag x)
    (if (pair? x)
        (attach '* x)
        x))
  (put 'deriv '* deriv-product)
  (put 'make 'product
       (lambda (x y) (tag (make-product x y)))))

(define (make-product m1 m2)
  ((get 'make 'product) m1 m2))

;;c)
(define (install-exponentiation-package)
  ;;internal procedures
  (define (base operands) (car operands))
  (define (exponent operands) (cadr operands))
  (define (make-exponentiation b e)
    (cond ((=number? b 0) 0)
          ((or (=number? b 1) (=number? e 0)) 1)
          ((=number? e 1) b)
          (else (list b e))))
  (define (deriv-exponent operands var)
    (let ((base (base operands))
          (exp (exponent operands)))
      (make-product (deriv base)
                    (make-product exp
                                  (make-exponentiation base
                                                       '(- exp 1))))))

  ;;interface to the rest of system
  (define (tag x)
    (if (pair? x)
        (attach-tag '** x)
        x))
  (put 'deriv '** deriv-exponentiation)
  (put 'make 'exponentiation
       (lambda (b e) (tag (make-exponentiation b e)))))

(define (make-exponentiation b e)
  ((get 'make 'exponentiation) b e))