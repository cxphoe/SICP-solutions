(load "assembler.rkt")

;; machine implementation
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (executed-number 0)               ; for counting the instructions
        (trace-mode false)                ; for trace mode
        (breakpoints '())                 ; for break point system
        (counters '()))                   ;
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
              (let ((first (car insts)))
                ; chenk the trace-mode, if true, trace the instructions
                (if trace-mode
                    (let ((label (instruction-label first))
                          (text (instruction-text first)))
                      (if (not (null? label))
                          (begin (display label)
                                 (display ":")
                                 (newline)))
                      (display "  ")
                      (display text)
                      (newline)))
                ; for breakpoints
                (if (not (null? breakpoints))
                    (let ((label (instruction-label first)))
                      (if (not (null? label))
                          (split label breakpoints '() '()))))

                (update)
                (if (or (null? counters)
                        (> (cdar counters) 0))
                    (begin
                      ((instruction-execution-proc first))
                      (set! executed-number
                            (+ executed-number 1))
                      (execute))
                    (begin (display (caar counters))
                           (set! counters (cdr counters))
                           (display ": ")
                           (display (instruction-text first))))))))

      (define (split label bps bp ct)
        (cond ((null? bps)
               (set! breakpoints bp)
               (set! counters (merge counters
                                    (map (lambda (x)
                                           (cons x (cadr x)))
                                         ct))))
              ((eq? (caar bps) label)
               (split label (cdr bps) bp (cons (car bps) ct)))
              (else
               (split label (cdr bps) (cons (car bps) bp) ct))))
      (define (merge seq1 seq2)
        (cond ((null? seq1) seq2)
              ((null? seq2) seq1)
              (else
               (merge (order-insert seq1 (car seq2))
                      (cdr seq2)))))
      (define (order-insert seq elt)
        (cond ((null? seq) (list elt))
              ((< (cdr elt) (cdar seq))
               (cons elt seq))
              (else
               (order-insert (cdr seq) elt))))
      (define (update)
        (for-each (lambda (c)
                    (set-cdr! c (- (cdr c) 1)))
                  counters))
             
      (define (filter proc seq)
        (cond ((null? seq) '())
              ((proc (car seq))
               (cons (car seq) (filter proc (cdr seq))))
              (else (filter proc (cdr seq)))))
      (define (remove-from-breakpoints seq elt)
        (if (null? seq)
            '()
            (cond ((equal? elt (car seq))
                   (cdr seq))
                  (else (cons (car seq)
                              (remove-from-breakpoints (cdr seq) elt))))))
      (define (remove-from-counters seq elt)
        (if (null? seq)
            '()
            (cond ((equal? (caar seq) elt)
                   (cdr seq))
                  (else (cons (car seq)
                              (remove-from-counters (cdr seq) elt))))))
      
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
              ((eq? message 'set-trace-label)
               (lambda (val) (set! trace-label val)))
              ; for breakpoint
              ((eq? message 'set-breakpoint!)
               (lambda (label n)
                 (set! breakpoints
                       (cons (list label n)
                             breakpoints))
                 'done))
              ((eq? message 'cancel-breakpoint)
               (lambda (label n)
                 (set! breakpoints
                       (remove-from-breakpoints breakpoints
                                                (cons label n)))
                 (set! counters
                       (remove-from-counters counters
                                             (cons label n)))
                 'done))
              ((eq? message 'cancel-all-breakpoints)
               (set! breakpoints '())
               (set! counters '())
               'done)
              ((eq? message 'proceed) (execute))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (start machine)
  (machine 'start))

(define (set-breakpoint machine label n)
  ((machine 'set-breakpoint!) label n))

(define (cancel-breakpoint machine label n)
  ((machine 'cancel-breakpoint) label n))

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

(define (no-trace-register machine reg-name)
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