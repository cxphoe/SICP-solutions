(define (count-pairs l)
  (let ((accessed-list '()))
    (define (recur l)
      (if (or (not (pair? l))
              (memq l accessed-list))
          0
          (begin (set! accessed-list (cons l accessed-list))
                 (+ 1
                    (count-pairs (car l))
                    (count-pairs (cdr l))))))
    (recur l)))
