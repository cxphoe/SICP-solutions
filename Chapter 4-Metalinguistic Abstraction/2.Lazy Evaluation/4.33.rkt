; input '(a b c) woulb read as (list 'quote (list a b c))
(define (eval-quote exp env)
  (let ((quoted (text-of-quotation exp env)))
    (if (pair? quoted)
        (make-list quoted)
        quoted)))

(define (make-lazy-pair x y)
  (list 'cons x y))

(define (make-list exps)
  (make-lazy-pair (list 'quote (car exps))
                  (list 'quote (cdr exps))))