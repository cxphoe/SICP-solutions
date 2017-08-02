(load "sequence_operation.rkt")

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-left / 1 (list 1 2 3))
(accumulate / 1 (list 1 2 3))

(accumulate list nil (list 1 2 3))
(fold-left list nil (list 1 2 3))

;;the op must be commutative to ensure the fold-right and
;;fold-left get the same result. Consider sequence to be
;;[x1, x2, ... xn], then (fold-left op init seq) would be
;;(op...(op (op init x1) x2)...xn), while the (fold-right
;;op init seq) would be (op x1 (op x2 ...(op xn init))).
(fold-left + 0 (list 1 2 3))
(accumulate + 0 (list 1 2 3))

(fold-left * 1 (list 1 2 3))
(accumulate * 1 (list 1 2 3))