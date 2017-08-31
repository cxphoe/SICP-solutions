;(load "machine-model.rkt")
(load "5.15.rkt")

(define fact-machine
  (make-machine
   (list (list '= =) (list '- -) (list '* *) (list 'read read)
         (list 'print (lambda (x)
                        (display x) (newline))))
   '(controller
     fact-loop
       (assign n (op read))                   ; add
       (assign continue (label fact-done))
     test-n
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label test-n))
     after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))
       (goto (reg continue))
     base-case
       (assign val (const 1))
       (goto (reg continue))
     fact-done
       (perform (op print) (reg val))
       (perform (op print-instruction-count)) ; add for 5.15.rkt
       (goto (label fact-loop)))))

(start fact-machine)