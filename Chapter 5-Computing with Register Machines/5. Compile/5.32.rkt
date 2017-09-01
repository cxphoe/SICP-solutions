; SICP exercise 5.32
;
; a) extend the evalutor to detect special expressions with symbol as
; operators.

(load "ev-operations-error/check-primitive.rkt")
(load "ev-operations-error/expression.rkt")
(load "ev-operations-error/environment.rkt")
(load "ev-operations-error/loop-setup.rkt")
(load "ev-operations-error/ev-operations.rkt")
(load "machine\\machine-model.rkt")
(load "machine\\assembler.rkt")

; an eval-machine from exercise 5.30
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
       (perform (op print-stack-statistics))
       (perform
        (op announce-output) (const ";;; EC-Eval value:"))
       (perform (op user-print) (reg val))
       (goto (label read-eval-print-loop))
     eval-dispatch
       (test (op self-evaluating?) (reg exp))
       (branch (label ev-self-eval))
       (test (op error?) (reg exp))
       (branch (label ev-error))
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
       (test (op error?) (reg val))
       (branch (label signal-error))
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
       (assign unev (op operands) (reg exp))       
       (assign exp (op operator) (reg exp))
       (test (op symbol?) (reg exp))                          ; changed
       (branch (label ev-appl-operator-symbol))               ; 
       (save env)
       (save unev)
       (assign continue (label ev-appl-did-operator))
       (goto (label eval-dispatch))
     ev-appl-operator-symbol                                  ;
       (assign continue (label ev-appl-did-operator-symbol))  ; add 
       (goto (label eval-dispatch))                           ;
     ev-appl-did-operator
       (restore unev)
       (restore env)
     ev-appl-did-operator-symbol                     ; add label
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
       (test (op error?) (reg val))
       (branch (label signal-error))
       (restore continue)
       (goto (reg continue))
     compound-apply
       (assign unev (op procedure-parameters) (reg proc))
       (assign env (op procedure-environment) (reg proc))
       (assign env (op extend-environment)
                   (reg unev) (reg argl) (reg env))
       (test (op error?) (reg env))
       (branch (label arity-error))
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

     ev-error
       (assign val (reg exp))
       (goto (label signal-error))

     arity-error
       (assign val (reg env))
       (goto (label signal-error))

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

; use (define (fib n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
; to test and the result is:

; +--------+--------------+---------------+
; |  n=10  | total-pushes | maximum-depth |
; +--------+--------------+---------------+
; | before |     4944     |      53       |
; | after  |     3708     |      53       |
; +--------+--------------+---------------+
