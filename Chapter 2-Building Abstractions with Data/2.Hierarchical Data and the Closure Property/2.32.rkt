;;(subsets s) equals to
;;(subsets (cdr s)) + (append (list (car s)) (subsets (cdr s)))
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (ss) (cons (car s)
                                             ss))
                          rest)))))

(subsets (list 1 2 3))