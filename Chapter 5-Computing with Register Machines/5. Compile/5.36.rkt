(define (construct-arglist operand-codes)
  (if (null? operand-codes)
      (make-instruction-sequence '() '(argl)
                                 '((assign argl (const ()))))
      (if (null? (cdr operand-codes))
          (append-instructoin-sequences
           (car operands-codes)
           (make-instruction-sequence
            '(val)
            '(argl)
            '((assign argl (op list) (reg val)))))
          (preserving '(env)
                      (append-instruction-sequences
                       (car operands-codes)
                       (make-instruction-sequence
                        '(val)
                        '(argl)
                        '((assign argl (reg val)))))
                      (code-to-get-rest-args (cdr operand-codes))))))

(define (code-to-get-args operand-codes)
  (if (null? (cdr operand-codes))
      (append-instruction-sequences
       (car operand-codes)
       (make-instruction-sequence
        '(val) '(argl)
        '((assign argl (op list) (reg val)))))
      (let ((code-for-next-arg
             (preserving '(argl)
                         (car operand-codes)
                         (make-instruction-sequence
                          '(val argl) '(argl)
                          '((assign argl
                                    (op cons) (reg argl) (reg val)))))))
        (preserving '(env)
                    code-for-next-arg
                    (code-to-get-args (cdr operand-codes))))))
