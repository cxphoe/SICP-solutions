(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*-assigns exp) (cadr exp))
(define (let*-body exp) (cddr exp))

(define (let*->nested-lets exp)
  (expand-assigns (let*-assigns exp) (let*-body exp)))

(define (expand-assigns assigns body)
  (if (null? assigns)
      body
      (make-let (car assigns)
                (expand-assigns (cdr assigns body)))))

(define (make-let assigns body)
  (list 'let assigns body))