(define (fib-machine-with-regs)
  (make-machine
   (list 'val 'n 'continue)
   (list (list '= =) (list '- -) (list '+ +) (list '< <))
   '(controller
       (assign continue (label fib-done))
     fib-loop
       (test (op <) (reg n) (const 2))
       (branch (label immediate-answer))
       ;; set up to compute Fib(n-1)
       (save continue)
       (assign continue (label afterfib-n-1))
       (save n)
       (assign n (op -) (reg n) (const 1))
       (goto (label fib-loop))
     afterfib-n-1
       (restore n)
       (assign n (op -) (reg n) (const 2))
       (assign continue (label afterfib-n-2))
       (save val)
       (goto (label fib-loop))
     afterfib-n-2
       (assign n (reg val))
       (restore val)
       (restore continue)
       (assign val
               (op +) (reg val) (reg n))
       (goto (reg continue))
     immediate-answer
       (assign val (reg n))
       (goto (reg continue))
     fib-done)))

(define (fib-machine-without-regs)
  (make-machine
   (list (list '= =) (list '- -) (list '+ +) (list '< <))
   '(controller
       (assign continue (label fib-done))
     fib-loop
       (test (op <) (reg n) (const 2))
       (branch (label immediate-answer))
       ;; set up to compute Fib(n-1)
       (save continue)
       (assign continue (label afterfib-n-1))
       (save n)
       (assign n (op -) (reg n) (const 1))
       (goto (label fib-loop))
     afterfib-n-1
       (restore n)
       (assign n (op -) (reg n) (const 2))
       (assign continue (label afterfib-n-2))
       (save val)
       (goto (label fib-loop))
     afterfib-n-2
       (assign n (reg val))
       (restore val)
       (restore continue)
       (assign val
               (op +) (reg val) (reg n))
       (goto (reg continue))
     immediate-answer
       (assign val (reg n))
       (goto (reg continue))
     fib-done)))

;(set-register-contents! fib-machine 'n 10)

(define (test-5.12)
  (load "5.12a.rkt")
  (define fib-machine (fib-machine-with-regs))
  (show fib-machine))

(define (test-5.13)
  (load "5.13.rkt")
  (define fib-machine (fib-machine-without-regs))
  (set-register-contents! fib-machine 'n 10)
  (start fib-machine)
  (get-register-contents fib-machine 'val))

(define (test-5.17)
  ; just test the trace mode
  (load "5.17.rkt")
  (define fib-machine (fib-machine-without-regs))
  (fib-machine 'trace-on)
  (set-register-contents! fib-machine 'n 10)
  (start fib-machine))

(define (test-5.18)
  (load "5.18.rkt")
  (define fib-machine (fib-machine-without-regs))
  (trace-register fib-machine 'val)
  (set-register-contents! fib-machine 'n 10)
  (start fib-machine)
  (display "Canceling trace for val...")
  (newline)
  (cancel-trace-register fib-machine 'val)
  (set-register-contents! fib-machine 'n 10)
  (start fib-machine)
  (get-register-contents fib-machine 'val))

; for 5.19
;(set-breakpoint fib-machine 'controller 1)
;(set-breakpoint fib-machine 'afterfib-n-2 10)
;(set-breakpoint fib-machine 'afterfib-n-1 5)
;(set-breakpoint fib-machine 'fib-loop 10)

