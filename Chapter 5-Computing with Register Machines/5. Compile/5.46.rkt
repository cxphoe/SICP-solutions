; SICP exercise 5.46
;
; inspect the stack operations of fib

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

; interpreted code test results from 5.29:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      16      |       8       |
; |  2  |      72      |      13       |
; |  3  |     128      |      18       |
; |  4  |     240      |      23       |
; |  5  |     408      |      28       |
; +-----+--------------+---------------+

; compiled code test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |       7      |       3       |
; |  2  |      14      |       4       |
; |  3  |      21      |       6       |
; |  4  |      35      |       8       |
; |  5  |      56      |      10       |
; |  6  |      91      |      12       |
; |  7  |     147      |      14       |
; |  8  |     238      |      16       |
; |  9  |     385      |      18       |
; | 10  |     623      |      20       |
; +-----+--------------+---------------+

; dedicated machine test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |       0      |       0       |
; |  2  |       3      |       2       |
; |  3  |       6      |       4       |
; |  4  |      12      |       6       |
; |  5  |      21      |       8       |
; |  6  |      36      |      10       |
; |  7  |      60      |      12       |
; |  8  |      99      |      14       |
; |  9  |     162      |      16       |
; | 10  |     264      |      18       |
; +-----+--------------+---------------+


(load "machine/machine-model.rkt")
(load "machine/assembler.rkt")

; another test machine
(define fib-machine
  (make-machine
   (list (list '= =) (list '- -) (list '+ +) (list '< <)
         (list 'display display))
   '(controller
       (perform (op initialize-stack))
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
     fib-done
       (perform (op display) (reg val))
       (perform (op print-stack-statistics)))))

(define (fib n)
  (set-register-contents! fib-machine 'n n)
  (start fib-machine))