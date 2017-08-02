(define (ripple-carry-adder A B S C)
  (let ((c-in (make-wire)))
    (set-signal! C 0)  ;ensure the initial signal value of C is 0
    (for-each (lambda (a b s)
                (set-signal! c-in (get-signal C))
                (full-adder a b c-in s C)))))
;the process in the ripple-carry-adder is merely change the relavant
;value in S and C, so there is no need to return some value.