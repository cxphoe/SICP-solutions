; SICP exercise 5.38
;
; implement open code for primitive procedure like '= '+ '- '*, to erase
; the redundant code for checking primitives' procedure type.

(load "compiler-instruction-sequence.rkt")

(define (open-code? exp)
  (and (pair? exp)
       (memq (car exp) open-operators)))

(define open-operators '(= - + *))

; a)
; I didn't do exactly what are asked by the exercise. During implementation
; I just found out that creating a generic compile is more elegant.
(define (general-compile op operands target linkage)
  (let ((arg1-code (compile (car operands) 'arg1 'next))
        (arg2-code (compile (cadr operands) 'arg2 'next)))
    (end-with-linkage
     linkage
     (preserving '(env)
      arg1-code
      (preserving '(arg1)
       arg2-code
       (make-instruction-sequence
        '(arg1 arg2) (list target)
        `((assign ,target (op ,op) (reg arg1) (reg arg2)))))))))

; b)
; detect the operator of procedure 
(define (compile-open-code exp target linkage)
  (let ((op (operator exp)) (args (operands exp)))
    (cond ((eq? op '=)
           (general-compile '= args target linkage))
           ((eq? op '-)
            (general-compile '- args target linkage))
           ((eq? op '+)
            (general-compile '+ (construct-operands '+ args)
                             target linkage))
           ((eq? op '*)
            (general-compile '* (construct-operands '* args)
                             target linkage)))))

; d)
; construct (+ 1 2 3 4 5) like: ((+ (+ (+ 1 2) 3) 4) 5)
(define (construct-operands op operands)
  (if (= 2 (length operands))
      operands
      (construct-operands op
       (cons (list op (car operands) (cadr operands))
             (cddr operands)))))
