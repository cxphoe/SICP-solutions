(define (single-stream? s)
  (and (not (null? s))
       (null? (stream-cdr s))))

(define (unique-query operands) (car operands))

(define (uniquely-asserted operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (let ((res-f (qeval (unique-query operands)
                         (singleton-stream frame))))
       (if (single-stream? res-f)
           res-f
           the-empty-stream)))
   frame-stream))

;; check
(assert! (rule (staff-with-one-supervisor ?p1 ?p2)
               (and (or (supervisor ?p1 ?p2)
                        (and (supervisor ?p1 ?p3)
                             (supervisor ?p3 p2)))
                    (unique (all-supervisors ?p1 ?p)))))