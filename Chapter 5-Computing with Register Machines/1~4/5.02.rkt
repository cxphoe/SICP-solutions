(controller
 test-n
   (assign product (const 1))
   (assign counter (const 1))
   (test (op >) (reg counter) (reg n))
   (branch (label iter-done))
   (assign t (op *) (reg counter) (reg product))
   (assign product (reg t))
   (assign t (op +) (reg counter) (const 1))
   (assign counter (reg t))
   (goto (label test-n))
 iter-done)