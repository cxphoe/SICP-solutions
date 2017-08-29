; input '(a b c) woulb read as (list 'quote (list a b c))
(define (text-of-quotation exp env)             ; changed for lazy-list
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval (make-list text) env)
        text)))

(define (make-lazy-pair x y)
  (list 'cons x y))

(define (make-list exps)
  (cond ((null? exps) (list 'quote '()))
        ((not (pair? exps)) exps)
        (else
         (make-lazy-pair (list 'quote (car exps))
                         (make-list (cdr exps))))))