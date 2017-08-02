(load "nested_mapping.rkt")

; 1 <= k < j < i <= n
(define (tri-sum-pairs n)
  (filter (lambda (pair) (= (tri-sum pair) n))
          (tri-pairs n)))

(define (tri-pairs n)
  (flatmap (lambda (i)
             (map (lambda (p) (cons i p))
                  (flatmap (lambda (j)
                             (map (lambda (k) (list j k))
                                  (enumerate-interval 1 (- j 1))))
                           (enumerate-interval 2 (- i 1)))))
           (enumerate-interval 3 n)))

(define (tri-sum pair)
  (+ (car pair) (cadr pair) (cadr (cdr pair))))

;(tri-sum-pairs 10)