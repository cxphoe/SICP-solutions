(load "machine-model.rkt")

(define append-machine
  (make-machine
   (list (list 'null? null?) (list 'car car) (list 'cons cons)
         (list 'display display) (list 'cdr cdr))
   '(controller
       (assign continue (label append-done))
     append-loop
       (test (op null?) (reg seq1))
       (branch (label after-split))
       (save continue)
       (assign temp (op car) (reg seq1))
       (assign seq1 (op cdr) (reg seq1))
       (save temp)
       (assign continue (label merge))
       (goto (label append-loop))
     merge
       (restore temp)
       (restore continue)
       (assign val (op cons) (reg temp) (reg val))
       (goto (reg continue))
     after-split
       (assign val (reg seq2))
       (goto (reg continue))
     append-done
       (perform (op display) (reg val)))))

(set-register-contents! append-machine 'seq1 '(1 2 3))
(set-register-contents! append-machine 'seq2 '(4 5 6))
(start append-machine)

(define append!-machine
  (make-machine
   (list (list 'set-cdr! set-cdr!) (list 'null? null?)
         (list 'cdr cdr) (list 'display display))
   '(controller
       (assign val (reg seq1))
     append!-loop
       (test (op null?) (reg seq1))
       (branch (label adjoin))
       (assign temp (reg seq1))
       (assign seq1 (op cdr) (reg seq1))
       (goto (label append!-loop))
     adjoin
       (perform (op set-cdr!) (reg temp) (reg seq2))
       (goto (label append!-done))
     append!-done
       (perform (op display) (reg val)))))

(set-register-contents! append!-machine 'seq1 '(1 2 3))
(set-register-contents! append!-machine 'seq2 '(4 5 6))
(start append!-machine)