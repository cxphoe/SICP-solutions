(load "3.70.rkt")

(define (square x) (* x x))
(define (square-sum p) (+ (square (car p)) (square (cadr p))))

(define square-weighted-stream
  (weighted-pairs integars integars square-sum))

(define (how-many-pairs n)
  (let ((matched-pairs false))
    (define (find-numbers s weight)
      (let ((first (stream-car s)))
        (cond ((not matched-pairs)
               (set! matched-pairs (list (weight first) first))
               (find-numbers (stream-cdr s) weight))
              ;; find the pairs with same weight
              ((= (weight first) (car matched-pairs))
               (set-cdr! matched-pairs
                         (cons first (cdr matched-pairs)))
               (find-numbers (stream-cdr s) weight))
              ;; the next pair's weight is not the same with previous
              ;; pairs'. Reset the matched-pairs and just ignore the
              ;; pairs if the amount of recorded pairs less than
              ;; required numbers.
              ((< (length (cdr matched-pairs)) n)
               (set! matched-pairs false)
               (find-numbers s weight))
              (else
               (let ((pairs matched-pairs))
                 (set! matched-pairs false)
                 (cons-stream pairs (find-numbers s weight)))))))
    find-numbers))

(define S
  ((how-many-pairs 3) square-weighted-stream
                      square-sum))