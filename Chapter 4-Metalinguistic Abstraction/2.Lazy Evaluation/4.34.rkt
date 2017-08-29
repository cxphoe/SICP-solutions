; change the expression as follows:
(eval '(define (cons x y)
         (raw-cons 'lazy-pair (lambda (m) (m x y))))
      the-global-environment)

(eval '(define (car z)
         (if (lazy-pair? z)
             ((raw-cdr z) (lambda (p q) p))
             "Cannot operate car on non-pair object"))
      the-global-environment)

(eval '(define (cdr z)
         (if (lazy-pair? z)
             ((raw-cdr z) (lambda (p q) q))
             "Cannot operate car on non-pair object"))
      the-global-environment)

;; raw-cons, raw-car, raw-cdr are the original pair operations
;; which are installed in the primitive package.

; (define primitive-procedures
;   (list (list 'raw-car car)
;         (list 'raw-cdr cdr)
;         (list 'raw-cons cons)
;         (list 'lazy-pair? lazy-pair?)
;         .....))

; other impletations
(define (lazy-pair? exp)
  (tagged-list? exp 'lazy-pair))

(define (lazy-car x env)
  (force-it (eval (list 'car x) env)))
(define (lazy-cdr x env)
  (force-it (eval (list 'cdr x) env)))

(define (print-lazy-pair seq env)
  (let ((limit 10))
    (define (print-seq seq count)
      (let ((first (lazy-car seq env))
            (rest (lazy-cdr seq env)))
        (if (< count limit)
            (begin (print-lazy-pair first env)
                   (if (not (lazy-pair? rest))
                       (if (not (null? rest)) ; for those not ending with nil
                           (begin (display " . ")
                                  (display rest)))
                       (begin (display " ")
                              (print-seq rest (+ count 1)))))
            (display "... "))))
    (if (lazy-pair? seq)
        (begin (display "(")
               (print-seq seq 0)
               (display ")"))
        (display seq))))

;; and change the original user-print as follows:
(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object))))
        ((lazy-pair? object)                                 ; changed
         (print-lazy-pair object the-global-environment))    ;
        (else (display object))))