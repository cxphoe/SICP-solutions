(define (install-polynomial-package)
  ;;internal procedures
  ;;representation of poly
  (define (make-poly variable coeff-list)
    (cons variable coeff-list))
  (define (variable p) (car p))
  (define (coeff-list p) (cdr p))

  (define variable? symbol?)
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

  ;;representation of terms and term lists
  (define (the-empty-coefflist) '())
  (define (first-term coeff-list)
    (make-term (- (length coeff-list) 1)
               (car coeff-list)))
  (define (rest-coeffs coeff-list) (cdr coeff-list))
  (define (empty-coefflist? coeff-list) (null? coeff-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (adjoin-term term coeff-list)
    (if (=zero? (coeff term))
        coeff-list
        (let ((t (first-term coeff-list)))
          (cond ((> (order term) (order t))
                 (if (= 1 (- (order term) (order t)))
                     (cons (coeff term) coeff-list)
                     (adjoin-term term (cons 0 coeff-list))))
                ((< (order term) (order t))
                 (cons (car coeff-list)
                       (adjoin-term term (rest-coeffs coeff-list))))
                (else
                 (cons (add (coeff term) (car coeff-list))
                       (rest-coeffs coeff-list)))))))

  ;;the rest of representation is similiar
  ;;with sparse polynomial expression