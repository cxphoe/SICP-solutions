(load "5.16.rkt")

; change the syntactic forms of instruction:
; add a empty list to store label

(define (make-instruction text)
  (list text '()))

(define (instruction-text inst)
  (car inst))

(define (instruction-label inst)
  (cadr inst))

(define (instruction-execution-proc inst)
  (cddr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-cdr! (cdr inst) proc))

(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels
       (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)
                   (error "Multiple used label: " next-inst)
                   ;------------add label to instructions------------;
                   (begin 
                     (if (not (null? insts))
                         (set-car! (cdr (car insts)) next-inst))
                     (receive insts
                              (cons (make-label-entry next-inst insts)
                                    labels))))
               (receive (cons (make-instruction next-inst) insts)
                        labels)))))))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        ;-----------add-----------;
        (executed-number 0)
        (trace-mode false))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics
                       (lambda () (stack 'print-statistics)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
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
      ;-----------------executed-number------------------;
      (define (print-executed-number)
        (display "Instruction count value: ")
        (display executed-number)
        (newline)
        (set! executed-number 0))
      (set! the-ops (cons (list 'print-instruction-count
                                (lambda () (print-executed-number)))
                          the-ops))
      ;--------------------------------------------------;
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ;--------------changed-------------;
                (if trace-mode
                    (begin (display (car (car insts)))
                           (newline)))
                ;----------------------------------;
                ((instruction-execution-proc (car insts)))
                (set! executed-number (+ executed-number 1))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ;---------------------changed--------------------;
              ((eq? message 'print-instruction-count-value)
               (print-executed-number))
              ((eq? message 'trace-on) (set! trace-mode true))
              ((eq? message 'trace-off) (set! trace-mode false))
              ;------------------------------------------------;
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))