(define (apply-generic op . args)
  (define (apply-iter op args)
    (if (= 1 (length args))
        (car args)
        (let ((current-args (list (car args) (cadr args)))
              (follow-args (cddr args)))
          (let ((type-tags (map type-tag current-args)))
            (let ((proc (get op type-tags)))
              (cond (proc (apply-iter op
                                      (cons (apply proc
                                                   (map contents
                                                        current-args))
                                            follow-args)))
                    ((not (eq? (car type-tags)
                               (cadr type-tags)))
                     (let ((type1 (car type-tags))
                           (type2 (cadr type-tags))
                           (a1 (car current-args))
                           (a2 (cadr current-args)))
                       (let ((t1->t2 (get-coercion type1 type2))
                             (t2->t1 (get-coercion type2 type1)))
                         (cond (t1->t2
                                (apply-iter op (append (list (t1->t2 a1) a2)
                                                       (follow-args))))
                               (t2->t1
                                (apply-iter op (append (list a1 (t2->t1 a2))
                                                       (folloe-args))))
                               (else
                                (error "No method for these types"
                                       (list op type-tags)))))))
                    (else
                     (error "No method for these types"
                            (list op type-tags)))))))))
  (apply-iter op args))