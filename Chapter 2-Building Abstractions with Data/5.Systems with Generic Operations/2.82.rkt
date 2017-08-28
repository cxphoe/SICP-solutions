(define (filter proc seq)
  (cond ((null? seq) nil)
        ((proc (car seq))
         (cons (car seq) (filter proc (cdr seq))))
        (else
         (filter proc (cdr seq)))))

(define (apply-generic op . args)
  ; find the type that all args can be coerced into, through
  ; filtering the given types.
  (define (find-generic-type arg-types type-tags)
    (cond ((null? type-tags) #f)
          ((null? arg-types) (car type-tags))
          (else
           (find-generic-type (cdr args)
                              (find-coercion-types (car args)
                                                   type-tags)))))
  ; find the types that the arg can be coerced into among given
  ; types; this will return a list due to the filter procedure
  (define (find-coercion-types arg-type type-tags)
    (filter (lambda (t2)
              (or (equal? arg-type t2)
                  (get-coercion arg-type t2)))
            type-tags))
  ; coerce all the args into target-type
  (define (coerce-all target-type)
    (map (lambda (arg)
           (let ((arg-type (type-tag arg)))
             (if (equal? arg-type target-type)
                 arg
                 ((get-coercion arg-type target-type) arg))))
         args))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((target-type (find-generic-type args)))
            (if target-type
                (apply apply-generic
                       (cons op (coerced-all target-type)))
                (error "no method for these types"
                       (list op type-args))))))))
