(load "5.16.rkt")

; add local state "trace-mode" default to "false"
; change instruction set of make-register
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

; add these procedure for machine instrustion
(define (trace-register machine reg-name)
  (trace-on (get-register machine reg-name)))

(define (cancel-trace-register machine reg-name)
  (trace-off (get-register machine reg-name)))