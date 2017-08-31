(load "5.12a.rkt")

; just change the procedure lookup-register in the make-new-mahcine:
(define (lookup-register name)
  (let ((val (assoc name register-table)))
    (if val
        (cadr val)
        (begin (allocate-register name) ; allocate register if reg isn't found
               (lookup-register name)))))

(define (make-machine ops controller-text)
  (let ((machine (make-new-machine)))
; and there is no need to allocate registers at the beginning
;    (for-each (lambda (register-name)
;                ((machine 'allocate-register) register-name))
;              register-names)
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        ;-----------update-------------;
        (instruction-category '())
        (label-regs '())
        (stacked-regs '())
        (register-val-source '())
        ;------------------------------;
        )
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiple defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (begin (allocate-register name)
                     (lookup-register name)))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      ;----------------------update--------------------;
      (define (update-data cate lregs sregs sources)
        (set! instruction-category cate)
        (set! label-regs lregs)
        (set! stacked-regs sregs)
        (set! register-val-source sources)
        'finished)
      ;------------------------------------------------;
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq)
                 (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ;---------------------update--------------------;
              ((eq? message 'update-data) update-data)
              ((eq? message 'show-data) (show-data instruction-category
                                                   label-regs
                                                   stacked-regs
                                                   register-val-source))
              ;-----------------------------------------------;
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))