(load "2.18.rkt")

(define x (list (list 1 2) (list 3 4) (list 5 6)))

(define (deep-reverse items)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items)
              (cons (if (pair? (car items))
                        (iter (car items) nil)
                        (car items))
                    res))))
  (iter items nil))

(deep-reverse x)