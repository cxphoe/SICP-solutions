(define (require? exp) (tagged-list? exp 'require))

(define (require-predicate exp) (cadr exp))

(define (analyze-require exp)
  (let ((proc (analyze (require-predicate exp))))
    (lambda (env succeed fail)
      (proc env
            (lambda (pred-value fail2)
              (if (not (true? pred-value))
                  (fail2)
                  (succeed 'ok fail2)))
            fail))))
                  