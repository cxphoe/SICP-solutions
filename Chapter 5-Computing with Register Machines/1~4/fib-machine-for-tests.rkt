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

(define (test-5.19)
  (load "5.19.rkt")
  (define fib-machine (fib-machine-without-regs))
  
  (set-breakpoint fib-machine 'afterfib-n-1 2)
  (set-breakpoint fib-machine 'afterfib-n-2 2)
  ;(set-breakpoint fib-machine 'afterfib-n-2 2)
  ;(set-breakpoint fib-machine 'text 10)
  ;(set-breakpoint fib-machine 'afterfib-n-2 20)
  ;(cancel-breakpoint fib-machine 'fib-loop 2)
  ;; check illegal breakpoints
  
  (set-register-contents! fib-machine 'n 10)
  (define (process)
    (proceed-machine fib-machine)
    (show fib-machine 'n)
    (show fib-machine 'val))

  ;(proceed-machine fib-machine)
  ;; check if the machine would report an error when there
  ;; is no interrupted instruction

  (start fib-machine)
  (show fib-machine 'n)
  (show fib-machine 'val)
  (circle process 8)
  (cancel-all-breakpoints fib-machine)
  (proceed-machine fib-machine)
  (display " ... ")
  (newline)
  (show fib-machine 'val)
  ;(proceed-machine fib-machine)
  )

(define (circle process times)
  (if (> times 0)
      (begin (process)
             (circle process (- times 1)))))

(define (show machine reg)
  (display reg)
  (display ": ")
  (display (get-register-contents machine reg))
  (newline))