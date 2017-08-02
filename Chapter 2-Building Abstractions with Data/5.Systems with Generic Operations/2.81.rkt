; a)
; call exp for two complex number will end up with a infinite loop.

; b)
; No. the procedure apply-generic won't run accurately as before.

; c)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (cond (proc (apply proc (map contents args)))
            ((and (not (eq? (car type-tags) (cadr type-tags)))
                  (= (length args) 2))
             (let ((type1 (car type-tags))
                   (type2 (cadr type-tags))
                   (a1 (car args))
                   (a2 (cadr args)))
               (let ((t1->t2 (get-coercion type1 type2))
                     (t2->t1 (get-coercion type2 type1)))
                 (cond (t1->t2
                        (apply-generic op (t1->t2 a1) a2))
                       (t2->t1
                        (apply-generic op a1 (t2->t1 a2)))
                       (else
                        (error "No method for these types"
                               (list op type-tags)))))))
            (else
             (error "No method for these types"
                    (list op type-tags)))))))