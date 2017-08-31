(load "assembler.rkt")

(define (filter proc seq)
  (cond ((null? seq) '())
        ((proc (car seq))
         (cons (car seq) (filter proc (cdr seq))))
        (else (filter proc (cdr seq)))))

;; machine implementation
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (executed-number 0)               ; for counting the instructions
        (trace-mode false)                ; for trace mode
        (labels '())                      ; for break point system
        (interrupted-inst false))         ;
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
      ; print count value of instructions
      (define (print-executed-number)
        (display "Instruction count value: ")
        (display executed-number)
        (newline)
        (set! executed-number 0))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (let* ((next-inst (car insts))
                     (breakpoint (instruction-breakpoint next-inst)))
                ; check the trace-mode, if true, trace the instructions
                (if trace-mode
                    (let ((label (instruction-label next-inst))
                          (text (instruction-text next-inst)))
                      (print-text label text)))
                (if breakpoint
                    (begin (show-breakpoint breakpoint)
                           (set! interrupted-inst next-inst))
                    (continue next-inst))))))
      
      (define (continue next-inst)
        ((instruction-execution-proc next-inst))
        (set! executed-number (+ executed-number 1))
        (execute))
      
      (define (print-text label text)
        (if (not (null? label))
            (begin (display "(TRACE) ")
                   (display label)
                   (display ":")
                   (newline)))
        (display "  ")
        (display text)
        (newline))
      ;-----------------------breakpoint---------------------------;
      (define (search-inst label-name offset)
        (let ((insts (lookup-label labels label-name)))
          ; do not need to check if label exist, the lookup-label
          ; will do this job for us
          (cond ((> (+ offset 1) (length insts))
                 (error "amount of instructions less than" offset))
                (else (list-ref insts offset)))))
      (define (set-breakpoint label-name offset)
        (set-break! (search-inst label-name offset)
                    (list label-name offset))
        'done)
      (define (cancel-breakpoint label-name offset)
        (cancel-break! (search-inst label-name offset))
        'done)
      (define (cancel-all-breakpoints)
        (for-each (lambda (inst)
                    (if (instruction-breakpoint inst)
                        (cancel-break! inst)))
                  the-instruction-sequence)
        'done)
      (define (show-breakpoint breakpoint)
        (display "BREAKPOINT ")
        (display breakpoint)
        (display ": ")
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
              ; print count value of instructions
              ((eq? message 'print-instruction-count-value)
               (print-executed-number))
              ; trace on and trace off
              ((eq? message 'trace-on) (set! trace-mode true))
              ((eq? message 'trace-off) (set! trace-mode false))
              ; for breakpoint
              ((eq? message 'install-labels)
               (lambda (ls) (set! labels ls)))
              ((eq? message 'set-breakpoint) set-breakpoint)
              ((eq? message 'cancel-breakpoint) cancel-breakpoint)
              ((eq? message 'cancel-all-breakpoints)
               (cancel-all-breakpoints))
              ((eq? message 'proceed) (proceed))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (start machine)
  (machine 'start))

(define (set-breakpoint machine label offset)
  ((machine 'set-breakpoint) label offset))

(define (cancel-breakpoint machine label offset)
  ((machine 'cancel-breakpoint) label offset))

(define (cancel-all-breakpoints machine)
  (machine 'cancel-all-breakpoints))

(define (proceed-machine machine)
  (machine 'proceed))

(define (get-register machine reg-name)
  ((machine 'get-register) reg-name))

(define (get-register-contents machine register-name)
  (get-contents (get-register machine register-name)))

(define (set-register-contents! machine register-name value)
  (set-contents! (get-register machine register-name) value)
  'done)

(define (trace-register machine reg-name)
  (trace-on (get-register machine reg-name)))

(define (cancel-trace-register machine reg-name)
  (trace-off (get-register machine reg-name)))

(define (make-machine ops controller-text)
  (let ((machine (make-new-machine)))
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

;; register implementation
(define (make-register name)
  (let ((contents '*unassigned*)
        (trace-mode false))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'set)
             (lambda (value)
               (if trace-mode
                   (begin (display "register ")
                          (display name)
                          (display ": ")
                          (display contents)
                          (display " => ")
                          (display value)
                          (newline)))
               (set! contents value)))
            ((eq? message 'trace-on) (set! trace-mode true))
            ((eq? message 'trace-off) (set! trace-mode false))
            (else
             (error "Unknown request -- REGISTER" message))))
    dispatch))

(define (get-contents register)
  (register 'get))

(define (set-contents! register value)
  ((register 'set) value))

(define (trace-on reg)
  (reg 'trace-on))

(define (trace-off reg)
  (reg 'trace-off))

;; stack implementation
(define (make-stack)
  (let ((s '())
        (number-pushes 0)
        (max-depth 0)
        (current-depth 0))
    (define (push val)                   
      (set! s (cons val s))
      (set! number-pushes (+ 1 number-pushes))
      (set! current-depth (+ 1 current-depth))
      (set! max-depth (max max-depth current-depth)))
    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            (set! current-depth (- current-depth 1))
            top)))
    (define (initialize)
      (set! s '())
      (set! number-pushes 0)
      (set! max-depth 0)
      (set! current-depth 0)
      'done)
    (define (print-statistics)
      (newline)
      (display (list 'total-pushes '= number-pushes
                     'maximum-depth '= max-depth)))
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) (pop))
            ((eq? message 'initialize) (initialize))
            ((eq? message 'print-statistics)
             (print-statistics))
            (else (error "Unknown request -- STACK" message))))
    dispatch))

(define (pop stack)
  (stack 'pop))

(define (push stack val)
  ((stack 'push) val))