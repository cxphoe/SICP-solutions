(load "5.15.rkt")

; change the implementation of instruction just like
; the display of labels in exercise 5.17
(define (make-instruction text)
  (list text '() false))

(define (instruction-text inst)
  (car inst))

(define (instruction-execution-proc inst)
  (cadr inst))

(define (instruction-breakpoint inst)
  (caddr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))

(define (set-break! inst breakpoint)
  (set-car! (cddr inst) breakpoint))

;----------------------------------------------------;

(define (assemble controller-text machine)
  (extract-labels controller-text
                  (lambda (insts labels)
                    (update-insts! insts labels machine)
                    insts)))

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
                   (receive insts
                            (cons (make-label-entry next-inst insts)
                                  labels)))
               (receive (cons (make-instruction next-inst) insts)
                        labels)))))))

(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    ;-------------------add----------------;
    ((machine 'install-labels) labels)
    ;--------------------------------------;
    (for-each
     (lambda (inst)
       (set-instruction-execution-proc!
        inst
        (make-execution-procedure
         (instruction-text inst) labels machine
         pc flag stack ops)))
     insts)))

;; machine implementation
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        ;-----------add----------;
        (labels '())
        (interrupted-inst false)
        ;------------------------;
        )
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
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              ;---------------------changed---------------------;
              (let* ((next-inst (car insts))
                     (breakpoint (instruction-breakpoint next-inst)))
                (if breakpoint
                    (begin (show-breakpoint breakpoint
                                            (instruction-text next-inst))
                           (set! interrupted-inst next-inst))
                    (continue next-inst))))))
      ; seperate the continue execute
      (define (continue next-inst)
        ((instruction-execution-proc next-inst))
        (execute))
      ;----------------------------add-----------------------------;
      (define (breakpoint-op label-name offset content)
        (let ((insts (lookup-label labels label-name)))
          (if (> (+ offset 1) (length insts))
              (error "not enough instructions -- BREAKPOINT")
              (set-break! (list-ref insts offset) content))
          'done))
      (define (set-breakpoint label-name offset)
        (breakpoint-op label-name offset
                       (list label-name offset)))
      (define (cancel-breakpoint label-name offset)
        (breakpoint-op label-name offset false))
      (define (cancel-all-breakpoints)
        (for-each (lambda (inst)
                    (set-break! inst false))
                  the-instruction-sequence)
        'done)
      (define (show-breakpoint breakpoint text)
        (display "BREAKPOINT ")
        (display breakpoint)
        (display ": ")
        (display text)
        (newline))
      (define (proceed)
        (if interrupted-inst
            (let ((next-inst interrupted-inst))
              (set! interrupted-inst false)
              (continue next-inst))
            (error "execution done! -- PROCEED")))
      ;------------------------------------------------------------;
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
              ((eq? message 'install-labels)
               (lambda (ls) (set! labels ls)))
              ((eq? message 'set-breakpoint) set-breakpoint)
              ((eq? message 'cancel-breakpoint) cancel-breakpoint)
              ((eq? message 'cancel-all-breakpoints)
               (cancel-all-breakpoints))
              ((eq? message 'proceed) (proceed))
              ;------------------------------------------------;
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (set-breakpoint machine label offset)
  ((machine 'set-breakpoint) label offset))

(define (cancel-breakpoint machine label offset)
  ((machine 'cancel-breakpoint) label offset))

(define (cancel-all-breakpoints machine)
  (machine 'cancel-all-breakpoints))

(define (proceed-machine machine)
  (machine 'proceed))