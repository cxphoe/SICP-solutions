(define (compile-variable exp target linkage compile-env)
  (let ((address (find-variable exp compile-env)))
    (end-with-linkage linkage
                      (make-instruction-sequence
                       '(env) (list target)
                       (if (eq? address 'not-found)
                           (list (list 'assign
                                       target
                                       '(op lookup-variable-value)
                                       (list 'const exp)
                                       '(reg env)))
                           (list (list 'assign
                                       target
                                       '(op lexical-address-lookup)
                                       (list 'const address)
                                       '(reg env))))))))

(define (compile-assignment exp target linkage compile-env)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next compile-env)))
    (let ((address (find-variable var compile-env)))
      (end-with-linkage
       linkage
       (preserving '(env)
                   get-value-code
                   (make-instruction-sequence
                    '(env val)
                    (list target)
                    (list (if (eq? address 'not-found)
                              (list (list perform
                                          '(op set-variable-value!)
                                          (list 'const var)
                                          '(reg val)
                                          '(reg env)))
                              (list (list perform
                                          '(op lexical-address-set!)
                                          (list 'const address)
                                          '(reg val)
                                          '(reg env))))
                          (list 'assign target '(const ok)))))))))