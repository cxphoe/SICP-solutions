; SICP exercise 5.36
;
; Inspect the evaluating order of expression'operands, and find a way to
; change it.

; The evaluation order is based on two procedure: construct-arglist and
; code-to-get-rest-args.

; I am not gonna implement another definition which has a left-to-right
; order. The basic idea is clear: don't reverse the operand-codes and
; operate append or reverse on the argl in the run time.
;
; But there is an issue with it.
;
; the implementation of construct-arglist in the textbook reverse the
; operands in the compiling process, and just use cons the build up the
; argl. If we didn't reverse the operands in construct-arglist, and set
; up instruction sequence like:
;
;   (assign val (op list) (reg val))
;   (assign argl (op append) (reg argl) (reg val))
;
; after each evaluation of arguments, or set up
;
;   ((assign argl (op reverse) (reg argl))
;
; after finishing the evaluation of whole arguments list.
; But as we know the cost of append and reverse is more than cons, which
; means there will be some loss in efficiency in the run time.

