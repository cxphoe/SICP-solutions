; SICP exercise 5.35
;
; deduce the expression from instruction sequence

; result:
(define (f x)
  (+ x (g (+ x 2))))

; the instruction sequence compiled by compiler:

  (assign val (op make-compiled-procedure) (label entry1) (reg env))
  (goto (label after-lambda2))
entry1
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const +) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const g) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const +) (reg env))
  (assign val (const 2))
  (assign argl (op list) (reg val))
  (assign val (op lookup-variable-value) (const x) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch3))
compiled-branch4
  (assign continue (label after-call5))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
primitive-branch3
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call5
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch6))
compiled-branch7
  (assign continue (label after-call8))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
primitive-branch6
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call8
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lookup-variable-value) (const x) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch9))
compiled-branch10
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
primitive-branch9
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call11
after-lambda2
  (perform (op define-variable!) (const f) (reg val) (reg env))
  (assign val (const ok))