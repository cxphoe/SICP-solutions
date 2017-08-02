(define (count-pairs l)
  (let ((accessed-list '()))
    (define (recur l)
      (if (or (not (pair? l))
              (is-in? l accessed-list))
          0
          (begin (set! accessed-list (cons l accessed-list))
                 (+ 1
                    (count-pairs (car l))
                    (count-pairs (cdr l))))))
    (recur l)))

(define (is-in? elts list)
  (cond ((null? list) false)
        ((eq? elts (car list)) true)
        (else (is-in? elts (cdr list)))))