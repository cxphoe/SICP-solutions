(load "machine-model.rkt")

;; a)
(define expt-machine
  (make-machine
   (list (list '= =) (list '- -) (list '* *) (list 'display display))
   '(controller
       (assign continue (label expt-done))
     expt-loop
       (test (op =) (reg n) (const 0))
       (branch (label base-case))
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-expt))
       (goto (label expt-loop))       
     after-expt
       (restore n)
       (restore continue)
       (assign val (op *) (reg b) (reg val))
       (goto (reg continue))
     base-case
       (assign val (const 1))
       (goto (reg continue))
     expt-done
       (perform (op display) (reg val)))))

(set-register-contents! expt-machine 'b 2)
(set-register-contents! expt-machine 'n 10)
(start expt-machine)

;; b)
(define expt2-machine
  (make-machine
   (list (list '= =) (list '- -) (list '* *) (list 'display display))
   '(controller
       (assign counter (reg n))
       (assign product (const 1))
     iter-loop
       (test (op =) (reg counter) (const 0))
       (branch (label iter-done))
       (assign t (op -) (reg counter) (const 1))
       (assign counter (reg t))
       (assign t (op *) (reg b) (reg product))
       (assign product (reg t))
       (goto (label iter-loop))
     iter-done
       (perform (op display) (reg product)))))

(set-register-contents! expt2-machine 'b 2)
(set-register-contents! expt2-machine 'n 10)
(start expt2-machine)