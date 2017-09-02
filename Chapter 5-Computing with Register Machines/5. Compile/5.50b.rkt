(define evaluator-text
  '(begin

    (define (map proc seq)
      (if (null? seq)
          '()
          (cons (proc (car seq))
                (map proc (cdr seq)))))
    
    (define (eval exp env)
      (cond ((self-evaluating? exp) exp)
            ((variable? exp) (lookup-variable-value exp env))
            ((quoted? exp) (text-of-quotation exp))
            ((and? exp) (eval (and->if exp) env))
            ((or? exp) (eval (or->if exp) env))
            ((do? exp) (eval (do->if exp) env))
            ((while? exp) (eval (while->combination exp) env))
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

    (define (apply procedure arguments)
      (cond ((primitive-procedure? procedure)
             (apply-primitive-procedure procedure arguments))
            ((compound-procedure? procedure)
             (eval-sequence
              (procedure-body procedure)
              (extend-environment
               (procedure-parameters procedure)
               arguments
               (procedure-environment procedure))))
            (else
             (error "Unknown procedure type -- APPLY" procedure))))

    (define (list-of-values exps env)
      (if (no-operands? exps)
          '()
          (cons (eval (first-operand exps) env)
                (list-of-values (rest-operands exps) env))))

    (define (eval-if exp env)
      (if (true? (eval (if-predicate exp) env))
          (eval (if-consequent exp) env)
          (eval (if-alternative exp) env)))

    (define (eval-sequence exps env)
      (cond ((last-exp? exps) (eval (first-exp exps) env))
            (else (eval (first-exp exps) env)
                  (eval-sequence (rest-exps exps) env))))

    (define (eval-assignment exp env)
      (set-variable-value! (assignment-variable exp)
                           (eval (assignment-value exp) env)
                           env)
      'ok)

    (define (eval-definition exp env)
      (define-variable!
        (definition-variable exp)
        (eval (definition-value exp) env)
        env)
      'ok)

    ; expression
    (define (primitive-procedure? proc)
      (tagged-list? proc 'primitive))

    (define (primitive-implementation proc) (cadr proc))

    (define primitive-procedures
      (list (list 'car car)
            (list 'cdr cdr)
            (list 'cons cons)
            (list 'list list)
            (list 'null? null?)
            (list '+ +)
            (list '* *)
            (list '- -)
            (list '/ /)
            (list '= =)
            (list '> >)
            (list '< <)
            (list '<= <=)
            (list '>= >=)
            (list 'display display)
            (list 'runtime runtime)))

    (define (primitive-procedure-names)
      (map car
           primitive-procedures))

    (define (primitive-procedure-objects)
      (map (lambda (proc) (list 'primitive (cadr proc)))
           primitive-procedures))

    (define (apply-primitive-procedure proc args)
      (apply-in-underlying-scheme
       (primitive-implementation proc) args))

    (define (true? x) (not (eq? x false)))
    (define (false? x) (eq? x false))

    (define (make-procedure parameters body env)
      (list 'procedure parameters body env))

    (define (compound-procedure? p)
      (tagged-list? p 'procedure))

    (define (procedure-parameters p) (cadr p))
    (define (procedure-body p) (caddr p))
    (define (procedure-environment p) (cadddr p))

    (define (self-evaluating? exp)
      (cond ((number? exp) true)
            ((string? exp) true)
            (else false)))

    (define (variable? exp) (symbol? exp))

    (define (quoted? exp) (tagged-list? exp 'quote))
    (define (text-of-quotation exp) (cadr exp))

    (define (tagged-list? exp tag)
      (if (pair? exp)
          (eq? (car exp) tag)
          false))

    (define (assignment? exp)
      (tagged-list? exp 'set!))

    (define (assignment-variable exp) (cadr exp))
    (define (assignment-value exp) (caddr exp))

    (define (make-assignment var val)
      (list 'set! var val))

    (define (definition? exp)
      (tagged-list? exp 'define))

    (define (definition-variable exp)
      (if (symbol? (cadr exp))
          (cadr exp)
          (caadr exp)))

    (define (definition-value exp)
      (if (symbol? (cadr exp))
          (caddr exp)
          (make-lambda (cdadr exp)
                       (cddr exp))))

    (define (make-definition var parameters body)
      (cons 'define (cons (cons var parameters) body)))

    (define (lambda? exp) (tagged-list? exp 'lambda))

    (define (lambda-parameters exp) (cadr exp))

    (define (lambda-body exp) (cddr exp))

    (define (make-lambda parameters body)
      (cons 'lambda (cons parameters body)))

    (define (if? exp) (tagged-list? exp 'if))

    (define (if-predicate exp) (cadr exp))
    (define (if-consequent exp) (caddr exp))
    (define (if-alternative exp)
      (if (not (null? (cdddr exp)))
          (cadddr exp)
          'false))

    (define (make-if predicate consequent alternative)
      (list 'if predicate consequent alternative))

    (define (begin? exp) (tagged-list? exp 'begin))

    (define (begin-actions exp) (cdr exp))

    (define (last-exp? exp) (null? (cdr exp)))
    (define (first-exp exp) (car exp))
    (define (rest-exps exp) (cdr exp))

    (define (sequence->exp seq)
      (cond ((null? seq) seq)
            ((last-exp? seq) (first-exp seq))
            (else (make-begin seq))))

    (define (make-begin seq) (cons 'begin seq))

    (define (application? exp) (pair? exp))

    (define (operator exp) (car exp))
    (define (operands exp) (cdr exp))

    (define (no-operands? ops) (null? ops))
    (define (first-operand ops) (car ops))
    (define (rest-operands ops) (cdr ops))

    (define (make-application proc arguments)
      (cons proc arguments))

    (define (cond? exp) (tagged-list? exp 'cond))

    (define (cond-clauses exp) (cdr exp))

    (define (cond-else-clause? clause)
      (eq? (cond-predicate clause) 'else))

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
                  (else (make-if (cond-predicate first)
                                 (sequence->exp (cond-actions first))
                                 (expand-clauses rest)))))))

    (define (let? exp)
      (tagged-list? exp 'let))

    (define (let-bindings exp) (cadr exp))
    (define (let-vars exp) (map car (let-bindings exp)))
    (define (let-vals exp) (map cadr (let-bindings exp)))

    (define (let-body exp) (cddr exp))

    (define (let->combination exp)
      (let ((vars (let-vars exp)) (vals (let-vals exp)))
        (make-application (make-lambda vars
                                       (let-body exp))
                          vals)))

    (define (make-let bindings body)
      (cons 'let (cons bindings body)))

    (define (and? exp)
      (tagged-list? exp 'and))

    (define (and-predicates exp) (cdr exp))

    (define (and->if exp)
      (expand-and-predicates (and-predicates exp)))

    (define (expand-and-predicates preds)
      (if (null? preds)
          'true
          (let ((first (car preds))
                (rest (cdr preds)))
            (if (null? rest)
                (make-if first first 'false)
                (make-if first
                         (expand-and-predicates rest)
                         'false)))))
  
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

    ; environment
    (define (enclosing-environment env) (cdr env))

    (define (first-frame env) (car env))

    (define the-empty-environment '())

    (define (make-frame variables values)
      (cons variables values))

    (define (frame-variables frame) (car frame))

    (define (frame-values frame) (cdr frame))

    (define (add-binding-to-frame! var val frame)
      (set-car! frame (cons var (car frame)))
      (set-cdr! frame (cons val (cdr frame))))

    (define (extend-environment vars vals base-env)
      (if (= (length vars) (length vals))
          (cons (make-frame vars vals) base-env)
          (if (< (length vars) (length vals))
              (error "Too many arguments supplied" vars vals)
              (error "Too few arguments supplied" vars vals))))

    ;; answer for question 4.12
    (define (env-loop env var var-not-in-frame proc)
      (define (scan vars vals)
        (cond ((null? vars) (var-not-in-frame env))
              ((eq? var (car vars)) (proc vals))
              (else
               (scan (cdr vars) (cdr vals)))))
      (if (eq? env the-empty-environment)
          (error "Unbound variable" var)
          (let ((frame (first-frame env)))
            (scan (frame-variables frame)
                  (frame-values frame)))))

    (define (lookup-variable-value var env)
      (define (var-not-in-frame env)
        (lookup-variable-value var (enclosing-environment env)))
      (env-loop env var var-not-in-frame car))

    (define (set-val! val)
      (lambda (vals) (set-car! vals val)))

    (define (set-variable-value! var val env)
      (define (var-not-in-frame env)
        (set-variable-value! var val (enclosing-environment env)))
      (env-loop env var var-not-in-frame (set-val! val)))

    (define (define-variable! var val env)
      (define (var-not-in-frame env)
        (add-binding-to-frame! var val (first-frame env)))
      (env-loop env var var-not-in-frame (set-val! val)))

    ; driver-loop
    (define input-prompt ";;; M-Eval input:")
    (define output-prompt ";;; M-Eval value:")

    (define (driver-loop)
      (prompt-for-input input-prompt)
      (let ((input (read)))
        (let ((output (eval input the-global-environment)))
          (announce-output output-prompt)
          (user-print output)))
      (driver-loop))

    (define (prompt-for-input string)
      (newline) (newline) (display string) (newline))

    (define (announce-output string)
      (newline) (display string) (newline))

    (define (user-print object)
      (if (compound-procedure? object)
          (display (list 'compound-procedure
                         (procedure-parameters object)
                         (procedure-body object)))
          (display object)))

    (define (setup-environment)
      (let ((initial-env
             (extend-environment (primitive-procedure-names)
                                 (primitive-procedure-objects)
                                 the-empty-environment)))
        (define-variable! 'true true initial-env)
        (define-variable! 'false false initial-env)
        initial-env))

    (define the-global-environment (setup-environment))))




;(load "compiler.rkt")
(define (test text)
  (for-each (lambda (x)
              (if (pair? x)
                  (begin (display "  ")))
              (display x)
              (newline))
            (caddr (compile text 'val 'next '()))))
;(test evaluator-text)