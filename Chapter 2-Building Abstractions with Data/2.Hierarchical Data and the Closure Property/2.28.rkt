(define leaf? (lambda (x) (not (pair? x))))

(define (fringe tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else
         (append (fringe (car tree))
                 (fringe (cdr tree))))))

(define x (list (list 1 (list 2 3)) (list 4 5)))

(fringe x)