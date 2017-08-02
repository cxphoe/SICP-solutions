(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-expand? clause)
  (eq? (cadr clause) '=>))

(define (cond-op clause) (caddr clause))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (cond ((cond-else-clause? first)
               (if (null? rest)
                   (sequence->exp (cond-actions first))
                   (error "ELSE clause isn't last -- COND->IF"
                          clauses)))
              ((cond-expand? first)
               ;;to avoid the potential effect caused by repeatedly
               ;;calling the predicate
               (make-application (make-lambda '(_parameter)
                                              (make-if _parameter
                                                       (make-application
                                                        (cond-op first)
                                                        _parameter)
                                                       (expand-clauses rest)))
                                 (cond-predicate first)))
              (else (make-if (cond-predicate first)
                             (sequence->exp (cond-actions first))
                             (expand-clauses rest)))))))

(define (make-application proc parameter)
  (cons proc parameter))