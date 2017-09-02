; SICP exercise 5.49
;
; Design a register machine which can execute a read-compile-eval-print
; loop.

; Actually, I don't think this machine will do any help. Checking if an
; expression is illegal is probably its main role.

(load "ev-operations-error/check-primitive.rkt")
(load "ev-operations-error/expression.rkt")
(load "ev-operations-error/environment.rkt")
(load "ev-operations-error/loop-setup.rkt")
(load "ev-operations-error/ev-operations.rkt")
(load "machine/machine-model.rkt")
(load "machine/assembler.rkt")
(load "compiler.rkt")

(define (compile-text text)
  (assemble (statements
             (compile text 'val 'return '()))
             comp-machine))

(set! eceval-operations
      (append `((make-compiled-procedure ,make-compiled-procedure)
                (compiled-procedure? ,compiled-procedure?)
                (compiled-procedure-entry ,compiled-procedure-entry)
                (compiled-procedure-env ,compiled-procedure-env)
                (lexical-address-lookup ,lexical-address-lookup)
                (lexical-address-set! ,lexical-address-set!)
                (compile-built-in ,compile-text))
              eceval-operations))

(define comp-machine
  (make-machine
   eceval-operations
   '(read-compile-eval-print-loop
       (perform (op initialize-stack))
       (perform
        (op prompt-for-input) (const ";;; EC-Comp input:"))
       (assign exp (op read))
       (assign env (op get-global-environment))
       (assign continue (label print-result))
       (assign val (op compile-built-in) (reg exp))
       (goto (reg val))
     print-result
       (perform (op print-stack-statistics))
       (perform
        (op announce-output) (const ";;; EC-Comp value:"))
       (perform (op user-print) (reg val))
       (goto (label read-compile-eval-print-loop))
     signal-error
       (perform (op user-print) (reg val))
       (goto (label read-compile-eval-print-loop)))))

(start comp-machine)