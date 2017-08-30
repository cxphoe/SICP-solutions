(load "5.12a.rkt")
;(load "machine-model.rkt")

(define fib-machine
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

(set-register-contents! fib-machine 'n 10)
;(fib-machine 'trace-on)
;(trace-register fib-machine 'val)
;(set-breakpoint fib-machine 'controller 1)
;(set-breakpoint fib-machine 'afterfib-n-2 10)
;(set-breakpoint fib-machine 'afterfib-n-1 5)
;(set-breakpoint fib-machine 'fib-loop 10)

(start fib-machine)

;; for 5.12
;(get-register-contents fib-machine 'val)
;(newline)
(show fib-machine)