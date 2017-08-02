(load "3.70.rkt")

(define (square x) (* x x))
(define (square-sum p) (+ (square (car p)) (square (cadr p))))

(define square-weighted-stream
  (weighted-pairs integars integars square-sum))

(define (how-many-pairs n)
  (let ((count 0))
    (define (find-number s weight res)
      ;; the res is a list containing  a number and some pairs with same
      ;; weight, and it would be empty at the beginning or the time we
      ;; need to find the next number
      (if (null? res)
          (begin (set! count (+ count 1))
                 (find-number (stream-cdr s)
                              weight
                              (list (weight (stream-car s))
                                    (stream-car s))))
          ;; find the pairs with same weight
          (if (= (weight (stream-car s)) (car res))
              (begin (set! count (+ count 1))
                     (find-number (stream-cdr s)
                                  weight
                                  (append res (list (stream-car s)))))
              ;; the next pair's weight is not the same with previous
              ;; pairs'. Reset the count and check if the amount of
              ;; recorded pairs less than given numbers.
              (let ((records count))
                (begin (set! count 0)
                       (if (>= records n)
                           (cons-stream res
                                        (find-number s weight '()))
                           (find-number s weight '())))))))
    find-number))

(define S
  ((how-many-pairs 3) square-weighted-stream
                      square-sum
                      '()))