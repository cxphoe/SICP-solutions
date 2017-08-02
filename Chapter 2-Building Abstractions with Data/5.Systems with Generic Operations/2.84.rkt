(load "2.83.rkt")

(define (raise-up a1 a2)
  (let ((type1 (type-tag a1))
        (type2 (type-tag a2)))
    (if (equal? type1 type2)
        a1
        (let ((upper (raise a1)))
          (if upper
              (raise-up upper a2)
              false)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (not (eq? type1 type2))
                (let ((a1-upper (raise-up a1 a2))
                      (a2-upper (raise-up a2 a1)))
                  (cond (a1-upper
                         (apply-generic op . a1-upper a2))
                        (a2-upper
                         (apply-generic op . a1 a2-upper))
                        (else
                         (error "No method for these types"
                                (list op type-tags)))))
                (error "No method for these types"
                       (list op type-tags))))))))