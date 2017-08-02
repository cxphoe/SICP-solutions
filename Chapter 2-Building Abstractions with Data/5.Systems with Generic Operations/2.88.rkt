(define (install-polynomial-package)
  ...
  ...
  (define (sub-terms L1 L2)
    (define (convert L)
      (if (null? L)
          '()
          (let ((t (first-term L)))
            (cons (make-term (order t)
                             (mul -1 (coeff t)))
                  (convert (rest-terms L))))))
    (add-terms L1 (convert L2)))

  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (sub-term (term-list p1)
                             (term-list p2)))
        (error "Polys not in same var -- SUB-POLY"
               (list p1 p2))))

  ...
  ...
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))