(actual-value '(define (cons x y) (lambda (m) (m x y)))
              the-global-environment)

(actual-value '(define (car z) (z (lambda (p q) p)))
              the-global-environment)

(actual-value '(define (cdr z) (z (lambda (p q) q)))
              the-global-environment)

(actual-value '(define (list-ref items n)
                 (if (= n 0)
                     (car items)
                     (list-ref (cdr items) (- n 1))))
              the-global-environment)

(actual-value '(define (map proc items)
                 (if (null? items)
                     '()
                     (cons (proc (car items))
                           (map proc (cdr items)))))
              the-global-environment)

(actual-value '(define (scale-list items factor)
                 (map (lambda (x) (* x factor))
                      items))
              the-global-environment)

(actual-value '(define (add-lists list1 list2)
                 (cond ((null? list1) list2)
                       ((null? list2) list1)
                       (else (cons (+ (car list1) (car list2))
                                   (add-lists (cdr list1) (cdr list2))))))
              the-global-environment)