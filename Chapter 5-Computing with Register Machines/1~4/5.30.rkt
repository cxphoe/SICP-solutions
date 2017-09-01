; SICP exercise 5.30
;
; Implement a error-handling system to handle the errors that appear
; in the run time, so that the system won't crash the exection.

; I merge the answer for a) and b). The basic idea is adding a prefix
; such as "error" just like the scheme. So we could raise an error by
; typing in format: (error <message> <error-source>) in the run time.
; So, basically I just imitate the error system just like the scheme
; language. But of course I can't locate the exact expression when an
; error occurs. Maybe I will implement it someday.

; For checking the primitve, there are two things have to check:
; -- 1st: arity
; -- 2nd: contract

(load "ev-operations/expression.rkt")
(load "ev-operations/environment.rkt")
(load "ev-operations/loop-setup.rkt")

; syntactic form of error
(define (make-error message . source)
  (cons 'error (cons message source)))

(define (error? obj)
  (tagged-list? obj 'error))

(define (error-message err)
  (cadr err))

(define (error-source err)
  (cddr err))

(define (print-err err)
  (display "\n")
  (display (error-message err))
  (for-each (lambda (x)
              (display " ")
              (display x))
            (error-source err)))

; change user-print to detect an error
(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object))))
        ;--------add---------;
        ((error? object)
         (print-err object))
        ;--------------------;
        (else
         (display object))))


; change the implementation of environment first
; extend the parameters
(define (extend-environment vars vals base-env)
  (or (arity-check vals #f (length vars) "")    ;arity-check defined below
      (cons (make-frame vars vals) base-env)))

(define (env-loop env var var-not-in-frame proc)
  (define (scan vars vals)
    (cond ((null? vars) (var-not-in-frame env))
          ((eq? var (car vars)) (proc vals))
          (else
           (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (make-error (unbound-error var))           ; changed
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))

(define (unbound-error var)
  (string-append (symbol->string var)
                 ": undefined;\n"
                 "  cannot reference undefined identifier"))

(load "ev-operations/ev-operations.rkt")

; add extra procedure to eceval-operations
(define eceval-operations
  (cons (list 'error? error?)
        eceval-operations))

; check the primitives
;; there are two things have to check for a primitive:
;; -- 1st: arity
;; -- 2nd: contract

;; for checking the arity
(define (arity-check args least expect pname)
  ;   args: passed in arguments of apply
  ;  least: lower limit of arity
  ; expect: expected arity
  ;  pname: the name string of primitives
  (let ((arity (length args)))
    (cond ((and least (< arity least))
           (make-error (arity-error pname least arity #t)))
          ((and expect (not (= arity expect)))
           (make-error (arity-error pname expect arity #f)))
          (else #f))))

(define (arity-error pname expect given least-mode)
  (string-append pname
                 ": arity mismatch;\n  "
                 (if least-mode
                     "expected: at least "
                     "expected: ")
                 (number->string expect)
                 "\n  given: "
                 (number->string given)))

;; for checking the contract
(define (contract-check args op pname cname)
  ;    op: for check contract
  ; pname: name string of primitives
  ; cname: name string of op
  (if (null? args)
      #f
      (let ((first (car args)))
        (if (op first)
            (contract-check (cdr args) op pname cname)
            (make-error (contract-error pname cname) first)))))

(define (contract-error pname cname)
  (string-append pname
                 ": contract violation\n"
                 "  expected: "
                 cname
                 "\n  given:"))

;(arity-check args least most pname)
;(contract-check args op pname cname)
;; for pair operations
(define (ccar . args)
  (or (arity-check args #f 1 "car")
      (contract-check args pair? "car" "pair?")
      (apply car args)))
        
(define (ccdr . args)
  (or (arity-check args #f 1 "cdr")
      (contract-check args pair? "cdr" "pair?")
      (apply cdr args)))

(define (ccons . args)
  (or (arity-check args #f 2 "cons")
      (apply cons args)))

(define (cnull? . args)
  (or (arity-check args #f 1 "null?")
      (apply null? args)))

;; for arithmatic signs
(define (c+ . args)
  (or (contract-check args number? "+" "number?")
      (apply + args)))

(define (c* . args)
  (or (contract-check args number? "*" "number?")
      (apply * args)))

(define (c- . args)
  (or (arity-check args 1 #f "-")
      (contract-check args number? "-" "number?")
      (apply - args)))

;; special case: division
(define (c/ . args)
  (or (arity-check args 1 #f "/")
      (contract-check args number? "/" "number?")
      (zero-check (cdr args))
      (apply / args)))

(define (zero-check args)
  (if (member 0 args)
      (make-error "/: division by zero")
      #f))

;; for comparison sign
(define (comparison-apply op args pname)
  (or (arity-check args 2 #f pname)
      (contract-check args number? pname "number?")
      (apply op args)))

(define (c= . args)
  (comparison-apply = args "="))

(define (c> . args)
  (comparison-apply > args ">"))

(define (c< . args)
  (comparison-apply < args "<"))

(define (c>= . args)
  (comparison-apply >= args ">="))

(define (c<= . args)
  (comparison-apply <= args "<="))

(define (ceq? . args)
  (or (arity-check args #f 2 pname)
      (apply op args)))

; now change the primitive-procedures
(define primitive-procedures
  (list (list 'car ccar)
        (list 'cdr ccdr)
        (list 'cons ccons)
        (list 'list list)    ; list don't need to check
        (list 'null? cnull?)
        (list '+ c+)
        (list '* c*)
        (list '- c-)
        (list '/ c/)
        (list '= c=)
        (list '> c>)
        (list '< c<)
        (list '<= c<=)
        (list '>= c>=)
        (list 'eq? ceq?)
        (list 'display display) ; these two I have no idea how to check
        (list 'runtime runtime)))

(define the-global-environment (setup-environment))
(load "machine-model.rkt")

; machine implementation

(define eval-machine
  (make-machine
   eceval-operations
   '(read-eval-print-loop
       (perform (op initialize-stack))
       (perform
        (op prompt-for-input) (const ";;; EC-Eval input:"))
       (assign exp (op read))
       (assign env (op get-global-environment))
       (assign continue (label print-result))
       (goto (label eval-dispatch))
     print-result
       ;(perform (op print-stack-statistics))
       (perform
        (op announce-output) (const ";;; EC-Eval value:"))
       (perform (op user-print) (reg val))
       (goto (label read-eval-print-loop))
     eval-dispatch
       (test (op self-evaluating?) (reg exp))
       (branch (label ev-self-eval))
       (test (op error?) (reg exp))      ; add for user interface
       (branch (label ev-error))         ; can use (error <me> <source>)
       (test (op variable?) (reg exp))
       (branch (label ev-variable))
       (test (op quoted?) (reg exp))
       (branch (label ev-quoted))
       (test (op assignment?) (reg exp))
       (branch (label ev-assignment))
       (test (op definition?) (reg exp))
       (branch (label ev-definition))
       (test (op if?) (reg exp))
       (branch (label ev-if))
       (test (op cond?) (reg exp))
       (branch (label ev-cond))
       (test (op lambda?) (reg exp))
       (branch (label ev-lambda))
       (test (op let?) (reg exp))
       (branch (label ev-let))
       (test (op begin?) (reg exp))
       (branch (label ev-begin))
       (test (op application?) (reg exp))
       (branch (label ev-application))
       (goto (label unknown-expression-type))
       
     ev-self-eval
       (assign val (reg exp))
       (goto (reg continue))
       
     ev-variable
       (assign val (op lookup-variable-value) (reg exp) (reg env))
       (test (op error?) (reg val))          ; add
       (branch (label signal-error))         ;
       (goto (reg continue))
       
     ev-quoted
       (assign val (op text-of-quotation) (reg exp))
       (goto (reg continue))
       
     ev-lambda
       (assign unev (op lambda-parameters) (reg exp))
       (assign exp (op lambda-body) (reg exp))
       (assign val (op make-procedure)
               (reg unev) (reg exp) (reg env))
       (goto (reg continue))
       
     ev-application
       (save continue)
       (save env)
       (assign unev (op operands) (reg exp))
       (save unev)
       (assign exp (op operator) (reg exp))
       (assign continue (label ev-appl-did-operator))
       (goto (label eval-dispatch))
     ev-appl-did-operator
       (restore unev)
       (restore env)
       (assign argl (op empty-arglist))
       (assign proc (reg val))
       (test (op no-operands?) (reg unev))
       (branch (label apply-dispatch))
       (save proc)
     ev-appl-operand-loop
       (save argl)
       (assign exp (op first-operand) (reg unev))
       (test (op last-operand?) (reg unev))
       (branch (label ev-appl-last-arg))
       (save env)
       (save unev)
       (assign continue (label ev-appl-accumulate-arg))
       (goto (label eval-dispatch))
     ev-appl-accumulate-arg
       (restore unev)
       (restore env)
       (restore argl)
       (assign argl (op adjoin-arg) (reg val) (reg argl))
       (assign unev (op rest-operands) (reg unev))
       (goto (label ev-appl-operand-loop))
     ev-appl-last-arg
       (assign continue (label ev-appl-accum-last-arg))
       (goto (label eval-dispatch))
     ev-appl-accum-last-arg
       (restore argl)
       (assign argl (op adjoin-arg) (reg val) (reg argl))
       (restore proc)
       (goto (label apply-dispatch))
       
     apply-dispatch
       (test (op primitive-procedure?) (reg proc))
       (branch (label primitive-apply))
       (test (op compound-procedure?) (reg proc))
       (branch (label compound-apply))
       (goto (label unknown-procedure-type))
     primitive-apply
       (assign val (op apply-primitive-procedure)
                   (reg proc)
                   (reg argl))
       (test (op error?) (reg val))          ; add
       (branch (label signal-error))         ;
       (restore continue)
       (goto (reg continue))
     compound-apply
       (assign unev (op procedure-parameters) (reg proc))
       (assign env (op procedure-environment) (reg proc))
       (assign env (op extend-environment)
                   (reg unev) (reg argl) (reg env))
       (test (op error?) (reg env))          ; add
       (branch (label arity-error))         ; when given arity don't equal the expected arity
       (assign unev (op procedure-body) (reg proc))
       (goto (label ev-sequence))
       
     ev-begin
       (assign unev (op begin-actions) (reg exp))
       (save continue)
       (goto (label ev-sequence))
       
     ev-sequence
       (assign exp (op first-exp) (reg unev))
       (test (op last-exp?) (reg unev))
       (branch (label ev-sequence-last-exp))
       (save unev)
       (save env)
       (assign continue (label ev-sequence-continue))
       (goto (label eval-dispatch))
     ev-sequence-continue
       (restore env)
       (restore unev)
       (assign unev (op rest-exps) (reg unev))
       (goto (label ev-sequence))
     ev-sequence-last-exp
       (restore continue)
       (goto (label eval-dispatch))
       
     ev-if
       (save exp)
       (save env)
       (save continue)
       (assign continue (label ev-if-decide))
       (assign exp (op if-predicate) (reg exp))
       (goto (label eval-dispatch))
     ev-if-decide
       (restore continue)
       (restore env)
       (restore exp)
       (test (op true?) (reg val))
       (branch (label ev-if-consequent))
     ev-if-alternative
       (assign exp (op if-alternative) (reg exp))
       (goto (label eval-dispatch))
     ev-if-consequent
       (assign exp (op if-consequent) (reg exp))
       (goto (label eval-dispatch))
       
     ev-assignment
       (assign unev (op assignment-variable) (reg exp))
       (save unev)
       (assign exp (op assignment-value) (reg exp))
       (save env)
       (save continue)
       (assign continue (label ev-assignment-1))
       (goto (label eval-dispatch))
     ev-assignment-1
       (restore continue)
       (restore env)
       (restore unev)
       (perform
        (op set-variable-value!) (reg unev) (reg val) (reg env))
       (assign val (const ok))
       (goto (reg continue))
       
     ev-definition
       (assign unev (op definition-variable) (reg exp))
       (save unev)
       (assign exp (op definition-value) (reg exp))
       (save env)
       (save continue)
       (assign continue (label ev-definition-1))
       (goto (label eval-dispatch))
     ev-definition-1
       (restore continue)
       (restore env)
       (restore unev)
       (perform
        (op define-variable!) (reg unev) (reg val) (reg env))
       (assign val (const ok))
       (goto (reg continue))

     ev-cond
       (assign unev (op cond-clauses) (reg exp))
       (save continue)
     ev-clauses
       (test (op null?) (reg unev))
       (branch (label ev-cond-done))
       (assign exp (op first-clause) (reg unev))
       (test (op cond-else-clause?) (reg exp))
       (branch (label ev-cond-clause-actions))
       (save unev)
       (save env)
       (save exp)
       (assign exp (op cond-predicate) (reg exp))
       (assign continue (label ev-cond-decide))
       (goto (label eval-dispatch))
     ev-cond-decide
       (restore exp)
       (restore env)
       (restore unev)
       (test (op true?) (reg val))
       (branch (label ev-cond-clause-actions))
     ev-cond-alternative
       (assign unev (op rest-clauses) (reg unev))
       (goto (label ev-clauses))
     ev-cond-clause-actions
       (assign unev (op cond-actions) (reg exp))
       (goto (label ev-sequence))
     ev-cond-done
       (goto (reg continue))

     ev-let
       (save continue)
       (save env)
       (save exp)
       (assign unev (op let-vars) (reg exp))
       (assign exp (op let-body) (reg exp))
       (assign val (op make-procedure)
                   (reg unev) (reg exp) (reg env))
       (restore exp)
       (assign unev (op let-vals) (reg exp))
       (save unev)
       (goto (label ev-appl-did-operator))

     ev-error                                  ;
       (assign val (reg exp))                  ; add
       (goto (label signal-error))             ;

     arity-error                               ;
       (assign val (reg env))                  ; add
       (goto (label signal-error))             ;

     unknown-expression-type
       (assign val (const unknown-expression-type-error))
       (goto (label signal-error))
     unknown-procedure-type
       (restore continue)
       (assign val (const unknown-procedure-type-error))
       (goto (label signal-error)) 

     signal-error
       (perform (op user-print) (reg val))
       (goto (label read-eval-print-loop))
     )))

(define (show name)
  (display (get-register-contents eval-machine name)))

;(trace-on eval-machine)
;(trace-register eval-machine 'exp)
;(set-breakpoint eval-machine 'print-result 1)

(start eval-machine)