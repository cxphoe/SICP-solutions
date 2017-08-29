(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval (and->if exp) env))
        ((or? exp) (eval (or->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;;and: (and <predicate1> <predicate2> ... <predicaten>)
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-predicates exp) (cdr exp))

(define (and->if exp)
  (expand-and-predicates (and-predicates exp)))

(define (expand-and-predicates preds)
  (if (null? preds)
      (make-if 'true 'true 'false)
      (let ((first (car preds))
            (rest (cdr preds)))
        (if (null? rest)
            (make-if first first false)
            (make-if first
                     (expand-and-predicates rest)
                     'false))))
  
;;or: (or <predicate1> <predicate2> ... <predicaten>)
(define (or? exp)
  (tagged-list? exp 'or))

(define (or-predicates exp) (cdr exp))

(define (or->if exp)
  (expand-or-predicates (or-predicates exp)))

(define (expand-or-predicates preds)
  (if (null? preds)
      'false
      (make-if (car preds)
               (car preds)
               (expand-or-predicates (cdr preds)))))