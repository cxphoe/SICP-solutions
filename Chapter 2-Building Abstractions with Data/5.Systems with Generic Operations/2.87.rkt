(define (install-polynomial-package)
  ;;;;
  ;;;;
  (define (=zero? coe)
    ;when the term-list is sorted by order, it means the
    ;the coefficient would not be zero as long as one
    ;term's coeff is not zero
    (define (list-test term-list)
      (cond ((null? term-list) true)
            ((=zero? (coeff (first-term term-list)))
             (list-test (rest-terms term-list)))
            (else false)))
    (cond ((number? coe) (= coe 0))
          ((and (pair? coe) (variable? (car coe)))
           (list-test coe))
          (else
           (error "wrong type -- =ZERO?"
                  (list coe)))))
                  

  (put '=zero? 'polynomial
       (lambda (x) (=zero? x)))
  'done)

(define (=zero? x)
  ((get '=zero? (type-tag x)) x))