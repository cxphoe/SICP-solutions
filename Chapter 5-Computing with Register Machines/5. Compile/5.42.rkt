; SICP exercise 5.42
;
; Rewrite compile-variable and compile-assignment to adopt the lexical-
; address by using find-vairable defined in exercise 5.40. If procedure
; find-variable return symbol 'not-found, then just lookup the variable
; in the-global-environment.

; Basic concept: set the var to the address and change relevant op so
; there's no need to repeat the code.

; variable
(define (compile-variable exp target linkage compile-env)
  (let ((address (find-variable exp compile-env))
        (op 'lookup-variable-value))
    (if (not (eq? address 'not-found))
        (begin (set! op 'lexical-address-lookup)
               (set! exp address)))
    (end-with-linkage linkage
     (make-instruction-sequence '(env) (list target)
      `((assign ,target
                (op ,op)
                (const ,exp)
                (reg env)))))))

; assignment
(define (compile-assignment exp target linkage compile-env)
  (let* ((var (assignment-variable exp))
         (get-value-code
          (compile (assignment-value exp) 'val 'next))
         (address (find-variable var compile-env))
         (op 'set-variable-value!))
    (if (not (eq? address 'not-found))
        (begin (set! op 'lexical-address-set!)
               (set! var address)))
    (end-with-linkage linkage
     (preserving '(env)
      get-value-code
      (make-instruction-sequence '(env val) (list target)
       `((perform (op ,op)
                  (const ,var)
                  (reg val)
                  (reg env))
         (assign ,target (const ok))))))))