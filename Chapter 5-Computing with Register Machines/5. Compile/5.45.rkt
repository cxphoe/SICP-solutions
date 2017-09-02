; SICP exercise 5.43
;
; Inspect the difference in total-pushes and maximum-depth between
; dedicated machine and interpreted or compiled code.

(load "machine/machine-model.rkt")
(load "machine/assembler.rkt")

; a) factorial
(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

; interpreted code test results from ex-5.27:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      16      |       8       |
; |  2  |      48      |      13       |
; |  3  |      80      |      18       |
; |  4  |     112      |      23       |
; |  5  |     144      |      28       |
; +-----+--------------+---------------+

; compiled code test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      5       |       3       |
; |  2  |      7       |       3       |
; |  3  |      9       |       4       |
; |  4  |     11       |       6       |
; |  5  |     13       |       8       |
; |  6  |     15       |      10       |
; |  7  |     17       |      12       |
; |  8  |     19       |      14       |
; |  9  |     21       |      16       |
; | 10  |     23       |      18       |
; +-----+--------------+---------------+

; dedicated machine test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      1       |       1       |
; |  2  |      2       |       2       |
; |  3  |      4       |       4       |
; |  4  |      6       |       6       |
; |  5  |      8       |       8       |
; |  6  |     10       |      10       |
; |  7  |     12       |      12       |
; |  8  |     14       |      14       |
; |  9  |     16       |      16       |
; | 10  |     18       |      18       |
; +-----+--------------+---------------+


; Actually, my definition of compiler has adopted the changes that the
; previous exercises ask (open code, lexical address ...), which means
; its efficiency has been improved. But as we can see, its test result
; still not as good as the dedicated machine, but both of them are in
; the same grow rate (n>=3) in total-pushes and maximum-depth. 

; compile instructions of factorial
;
;  (assign val (op make-compiled-procedure) (label entry1) (reg env))
;  (goto (label after-lambda2))
;entry1
;  (assign env (op compiled-procedure-env) (reg proc))
;  (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
;  (assign arg1 (op lexical-address-lookup) (const (0 0)) (reg env))
;  (assign arg2 (const 1))
;  (assign val (op =) (reg arg1) (reg arg2))
;  (test (op false?) (reg val))
;  (branch (label false-branch4))
;true-branch3
;  (assign val (const 1))
;  (goto (reg continue))
;false-branch4
;  (save continue)             ;; push
;  (save env)                  ;; push
;  (assign proc (op lookup-variable-value) (const factorial) (reg env))
;  (assign arg1 (op lexical-address-lookup) (const (0 0)) (reg env))
;  ......
;  ......
;after-if5
;after-lambda2
;  (perform (op define-variable!) (const factorial) (reg val) (reg env))
;  (assign val (const ok))

(define fact-machine
  (make-machine
   (list (list '= =) (list '- -) (list '* *) (list 'display display))
   '(controller
       (perform (op initialize-stack))
       (assign continue (label fact-done))
     fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)                        ; push
       (save n)                               ; push
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label fact-loop))
     after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))
       (goto (reg continue))
     base-case
       (assign val (const 1))
       (goto (reg continue))
     fact-done
       (perform (op display) (reg val))
       (perform (op print-stack-statistics)))))

(define (fact n)
  (set-register-contents! fact-machine 'n n)
  (start fact-machine))

; b)
; The compiled instructions is functioning good enough as we can see.
; I just can't come up with something better.