; SICP exercise 5.48
;
; Augment the compiler-interpreter interface by adding a compile-and-run
; primitive that can be called form within the explicit-control evaluator.

; add these to the evaluator.

; ev-compile
;  (save continue)
;  (assign exp (op compile-text) (reg exp))
;  (assign continue (label ev-compile-text))
;  (goto (label eval-dispatch))
; ev-compile-text
;  (restore continue)
;  (assign val (op compile-instructions) (reg val))
;  (goto (reg val))

(define (compile-run? exp)
  (tagged-list? exp 'compile-and-run))

(define (compile-text exp)
  (cadr exp))

(define (compile-instructions text)
  (assemble (statements
             (compile text 'val 'return '()))
             eval-machine))