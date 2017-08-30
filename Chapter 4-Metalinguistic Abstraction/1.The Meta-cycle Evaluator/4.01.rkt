; left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env)))
        (let ((rest (list-of-values (rest-operands exps) env)))
          (cons first rest)))))

; right to left
(define (list-of-values2 exps env)
  (if (no-operands? exps)
      '()
      (let ((rest (list-of-values2 (rest-operands exps) env)))
        (let ((first (eval (first-operand exps) env)))
          (cons first rest)))))