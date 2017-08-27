(load "2.18.rkt")

(define x (list (list 1 2) (list 3 4) (list 5 6)))

(define (deep-reverse-iter items)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items)
              (cons (if (pair? (car items))
                        (iter (car items) nil)
                        (car items))
                    res))))
  (iter items nil))

(define (deep-reverse-recur items)
  (cond ((null? items) '())
        ((pair? items)
         (let ((first (car items))
               (rest (cdr items)))
           (append (deep-reverse-1 rest)
                   (list (deep-reverse-1 first)))))
        (else items)))

(define (show x)
  (display x) (newline))

(show x)
(show (deep-reverse-iter x))
(show (deep-reverse-recur x))