(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            (let ((l (length choices)))
              (let ((c (list-ref choices (random l))))
                (c env
                   succeed
                   (lambda ()
                     (try-next (remove choices c))))))))
      (try-next cprocs))))

(define (remove seq elt)
  (cond ((null? seq) '())
        ((eq? elt (car seq))
         (cdr seq))
        (else
         (cons (car seq) (remove (cdr seq) elt)))))