(controller
 (assign guess (const 1.0))
 test-guess
   (assign t (op *) (reg guess) (reg guess))
   (assign t (op -) (reg t) (reg guess))
   (assign t (op abs) (reg t))
   (test (op <) (reg t) (const 0.001))
   (branch (label sqrt-done))
   (goto (label improve-guess))
 improve-guess
   (assign t (op /) (reg x) (reg guess))
   (assign t (op +) (reg guess) (reg t))
   (assign t (op /) (reg t) (const 2))
   (assign guess (reg t))
   (goto (label test-guess))
 sqrt-done)