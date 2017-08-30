;;normal let
(define (let? exp)
  (tagged-list? exp 'let))

(define (let-bindings exp) (cadr exp))
(define (let-variables exp) (map car (let-expressions exp)))
(define (let-params exp) (map cadr (let-expressions exp)))
(define (let-body exp) (cddr exp))

;;named-let: (let <var> <bindings> <body>)
(define (named-let? exp)
  (and (tagged-list? exp 'let)
       (symbol? (cadr exp))))

(define (named-let-name exp) (cadr exp))
(define (named-let-bindings exp) (caddr exp))
(define (named-let-body exp) (cdddr exp))

(define (let->combination exp)
  (if (named-let? exp)
      ;; apply the func to the parameters after finish the definition
      ;; of func
      (name-let->app (named-let-name exp)
                     (named-let-bindings exp)
                     (named-let-body exp))
      (make-application (make-lambda (map car (let-bindings exp))
                                     (let-body exp))
                        (map cadr (let-bindings exp)))))

(define (name-let->app name bindings body)
  (sequence->exp
   (list (make-definition name (map car bindings) body)
         (make-application name (map cadr bindings)))))

(define (make-application proc parameters)
  (cons proc parameters))

(define (make-definition var parameters body)
  (list 'define
        var
        (make-lambda parameters body)))