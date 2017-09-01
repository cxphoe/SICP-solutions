; SICP exercise 5.33
;
; inspect the difference between compiling result of two definition of
; factorial:
; --1st: (define (factorial n)
;          (if (= n 1)
;              1
;              (* (factorial (- n 1)) n)))
;
; --2nd: (define (factorial-alt n)
;          (if (= n 1)
;              1
;              (* n (factorial (- n 1)))))

; if-predicate and if-consequent don't differ in compiling, instead of
; if-alternative.
;
; What matter most is that the evaluate order of the operands. Because
; the consturct-arglist, the compiling order of arguments if from right
; to left.

; In the first definition, first arg to compile is n, so it need register
; env and modify nothing. (factorial (- n 1)) is the second to compile,
; and there is already a argl exised, so it will need to save argl.

; In the second definition, frist arg to compile is (factorial (- n 1))
; which is a compiled procedure, so it will need to save env extra
; because it will need to modify env. But it won't need to save argl,
; because there is no argl yet.

; So, literally, there's no difference in efficiency.