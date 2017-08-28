(define (install-polynomial-package)
  ;;;;
  ;;;;
  (define (zero-poly? poly)
    ;when the term-list is sorted by order, it means the
    ;the coefficient would not be zero as long as one
    ;term's coeff is not zero
    (define (list-test term-list)
      (cond ((null? term-list) true)
            ((=zero? (coeff (first-term term-list)))
             (list-test (rest-terms term-list)))
            (else false)))
    (cond ((and (pair? poly) (variable? (car poly)))
           (list-test (term-list poly)))
          (else
           (error "wrong type -- =ZERO?" (list poly)))))
                  

  (put '=zero? 'polynomial
       (lambda (x) (zero-poly? x)))
  'done)

(define (=zero? x)
  ((get '=zero? (type-tag x)) x))