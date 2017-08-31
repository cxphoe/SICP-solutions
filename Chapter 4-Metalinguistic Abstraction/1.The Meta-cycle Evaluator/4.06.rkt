;;let: (let ((<var1> <exp1>) ... (<varn> <expn>))
;;       <body>)
(define (let? exp)
  (tagged-list? exp 'let))

(define (let-assigns exp) (cadr exp))
(define (let-variables exp) (map car (let-assigns exp)))
(define (let-params exp) (map cadr (let-assigns exp)))

(define (let-body exp) (cddr exp))

(define (let->combination exp)
  (make-application
   (make-lambda (let-variables exp)
                (let-body exp))
   (let-params exp)))

(define (make-application proc parameters)
  (cons proc parameters))

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
        ((let? exp)
         (eval (let->combination exp) env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))