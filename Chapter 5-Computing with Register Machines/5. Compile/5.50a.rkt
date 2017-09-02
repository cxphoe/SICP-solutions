; SICP exercise 5.50
;
; Use the compiler to compile the metacircular evaluator of section 4.1
; and run this program using the register-machine simulator. (To compile
; more than one definition at a time, you can package the definitions in
; a begin.) The resulting interpreter will run very slowly because of
; the multiple levels of interpretation, but getting all the details to
; work is an instructive exercise.


(load "ev-operations-error/check-primitive.rkt")
(load "ev-operations/expression.rkt")
(load "ev-operations/environment.rkt")
(load "ev-operations/loop-setup.rkt")
(load "ev-operations/ev-operations.rkt")
(load "machine/machine-model.rkt")
(load "machine/assembler.rkt")
(load "compiler.rkt")
(load "5.50b.rkt")
(load "5.50c.rkt")
(set! eceval-operations
      (append `((make-compiled-procedure ,make-compiled-procedure)
                (compiled-procedure? ,compiled-procedure?)
                (compiled-procedure-entry ,compiled-procedure-entry)
                (compiled-procedure-env ,compiled-procedure-env)
                (lexical-address-lookup ,lexical-address-lookup)
                (lexical-address-set! ,lexical-address-set!)
                )
              eceval-operations))

(define primitive-procedures
  (append `((number? ,number?)
            (pair? ,pair?)
            (symbol? ,symbol?)
            (set-car! ,set-car!)
            (set-cdr! ,set-cdr!)
            (apply-in-underlying-scheme ,apply)
            (length ,length)
            (cadr ,cadr))
          primitive-procedures))

(define the-global-environment (setup-environment))

(define machine
  (make-machine
   eceval-operations
   evaluator-instructions)) ; evaluator-instructions from 5.50c

(define (set-reg name value)
  (set-register-contents! machine name value))

(set-reg 'env the-global-environment)

(define (show name)
  (display (get-register-contents machine name)))

; use trace mode and you'll be able to inspect the whole path

(trace-on machine)
;(trace-register machine 'val)
;(set-breakpoint machine 'print-result 1)

(start machine)
;(total-pushes = 757 maximum-depth = 56)
;Instruction count value: 6006