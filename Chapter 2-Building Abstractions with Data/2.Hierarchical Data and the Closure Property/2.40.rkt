(load "nested_mapping.rkt")

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j)
                    (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 2 n)))

(define (prime-sum-pairs-simplied n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))