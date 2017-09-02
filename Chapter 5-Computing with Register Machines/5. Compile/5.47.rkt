; SICP exercise 5.47
;
; Show how to modify the compiler so that compiled procedures can call
; not only primitive procedures and compiled procedures, but interpreted
; procedures as well.

(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive-branch))
        (compound-branch (make-label 'compound-branch))
        (compiled-branch (make-label 'compiled-branch)); create branch
        (after-call (make-label 'after-call)))
    (let ((compiled-linkage
           (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
       (make-instruction-sequence '(proc) '()
        `((test (op primitive-procedure?) (reg proc))
          (branch (label ,primitive-branch))
          (test (op compound-procedure?) (reg proc))   ; add test
          (branch (label ,compound-branch))))          ;
       (parallel-instruction-sequences
        (append-instruction-sequences
         compiled-branch
         (compile-proc-appl target compiled-linkage))
        (parallel-instruction-sequences
         (append-instruction-sequences                 ;
          compound-branch                              ; compound branch
          (compound-apply target compiled-linkage))    ;
         (append-instruction-sequences
          primitive-branch
          (primitive-apply target linkage)))) ; I have extracted the primitive apply
       after-call))))

(define all-regs '(env proc val argl continue))

(define (primitive-apply target linkage)
  (end-with-linkage linkage
   (make-instruction-sequence '(proc argl) (list target)
    `((assign
       ,target
       (op apply-primitive-procedure)
       (reg proc)
       (reg argl))))))

; the register continue has to be saved for all possibilities, to ensure
; the procedure return the val
(define (compound-apply target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
         (make-instruction-sequence '(proc) all-regs
          `((assign continue (label ,linkage))
            (save continue)
            (goto (reg compapp)))))
        ((and (not (eq? target 'val))
              (not (eq? linkage 'return)))
         (let ((proc-return (make-label 'proc-return)))
           (make-instruction-sequence '(proc) all-regs
            `((assign continue (label ,proc-return))
              (save continue)
              (goto (reg compapp))
              ,proc-return
              (assign ,target (reg val))
              (goto (label ,linkage))))))
        ((and (eq? target 'val) (eq? linkage 'return))
         (make-instruction-sequence '(proc continue) all-regs
          `((save continue)
            (goto (reg compapp)))))
        ((and (not (eq? target 'val)) (eq? linkage 'return))
         (error "return linkage, target not val -- COMPILE" target))))