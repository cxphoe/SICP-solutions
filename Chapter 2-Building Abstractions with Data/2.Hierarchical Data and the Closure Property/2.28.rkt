(define leaf? (lambda (x) (not (pair? x))))

(define (fringe tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else
         (append (fringe (car tree))
                 (fringe (cdr tree))))))

(define (fringe-iter tree)
  (define (iter tree result)
    (cond ((null? tree)
           result)
          ((pair? tree)
           (iter (cdr tree)
                 (append result
                         (iter (car tree) '()))))
          (else (list tree))))
  (iter tree '()))

(define x (list (list 1 (list 2 3)) (list 4 5)))

(define (show x)
  (display x) (newline))

(show x)
(show (fringe x))
(show (fringe-iter x))