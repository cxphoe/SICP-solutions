(define (reverse items)
  (define (reverse-iter item res)
    (if (null? item)
        res
        (reverse-iter (cdr item)
                      (cons (car item) res))))
  (reverse-iter items '()))