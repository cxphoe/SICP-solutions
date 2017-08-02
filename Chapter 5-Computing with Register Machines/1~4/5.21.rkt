(load "machine-model.rkt")

;; a)
(define recur-machine
  (make-machine
   (list (list 'null? null?) (list 'pair? pair?) (list '+ +)
         (list 'car car) (list 'cdr cdr))
   '(controller
       (assign continue (label count-done))
     count-loop
       (test (op null?) (reg tree))
       (branch (label zero-case))
       (test (op pair?) (reg tree))
       (branch (label pair-case))
       (assign val (const 1))
       (goto (reg continue))
     pair-case
       (save continue)
       (save tree)
       (assign continue (label after-count-car))
       (assign tree (op car) (reg tree))
       (goto (label count-loop))
     after-count-car
       (restore tree)
       (assign tree (op cdr) (reg tree))
       (assign continue (label after-count-cdr))
       (save val)
       (goto (label count-loop))
     after-count-cdr
       (assign n (reg val))
       (restore val)
       (restore continue)
       (assign val (op +) (reg val) (reg n))
       (goto (reg continue))
     zero-case
       (assign val (const 0))
       (goto (reg continue))
     count-done)))

;(set-register-contents! recur-machine 'tree '((1 2) 3 4))
;(start recur-machine)
;(get-register-contents recur-machine 'val)

;; b)
(define iter-machine
  (make-machine
   (list (list 'null? null?) (list 'pair? pair?) (list '+ +)
         (list 'car car) (list 'cdr cdr))
   '(controller
       (assign n (const 0))
       (assign continue (label count-done))
     iter-loop
       (test (op null?) (reg tree))
       (branch (label null-case))
       (test (op pair?) (reg tree))
       (branch (label pair-case))
       (assign val (op +) (reg n) (const 1))
       (goto (reg continue))
     pair-case
       (save continue)
       (save tree)
       (assign continue (label after-count-car))
       (assign tree (op car) (reg tree))
       (goto (label iter-loop))
     after-count-car
       (restore tree)
       (assign n (reg val))
       (assign tree (op cdr) (reg tree))
       (assign continue (label after-count-cdr))
       (goto (label iter-loop))
     after-count-cdr
       (assign n (reg val))
       (restore continue)
       (goto (reg continue))
     null-case
       (goto (reg continue))
     count-done)))

(set-register-contents! iter-machine 'tree '(((1 2) (4)) (3 4) 5))
(start iter-machine)
(get-register-contents iter-machine 'val)
