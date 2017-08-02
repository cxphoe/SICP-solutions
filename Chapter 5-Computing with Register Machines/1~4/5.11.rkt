;; b)
(define (make-save inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst))
        (reg (get-register machine reg-name)))
    (lambda ()
      (push stack (cons reg-name (get-contents reg))
      (advance-pc pc)))))

(define (make-restore inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst))
        (reg (get-register machine reg-name)))
    (lambda ()
      (let ((val (pop stack)))
        (if (eq? (car val) (car reg-name))
            (begin (set-contents! reg (cdr val))
                   (advance-pc pc))
            (error "Pop to the wring register -- MAKE-RESOTRE"
                   reg-name))))))

;; c)
(define (make-stack)
  (let ((s '()))
    (define (push reg)                            ; changed because
      (let ((reg-stack (assoc (car reg) s)))      ; parameter because
        (set-cdr! reg-stack                       ; (<name> <val>)
                  (cons (cdr reg) (cdr reg-stack)))))
    (define (pop reg-name)
      (let ((reg-stack (assoc reg-name s)))
        (if (null? (cdr reg-stack))
            (error "Empty stack -- POP" (car reg))
            (let ((top (cadr reg-stack)))
              (set-cdr! reg-stack (cddr reg-stack))
              top))))
    (define (add reg-name)                       ; new definition for
      (set! s (cons (list reg-name) s)))         ; add new reg stack
    (define (initialize)
      (set! s (for-each (lambda (stack)
                          (set-cdr! stack '()))
                        s))
      'done)
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) pop)
            ((eq? message 'add) add)             ; changed
            ((eq? message 'initialize) (initialize))
            (else (error "Unknown request -- STACK" message))))
    dispatch))

(define (pop stack value)
  ((stack 'pop) value))

(define (push stack value)
  ((stack 'push) value))

(define (add stack reg-name)                     ; changed
  ((stack 'add) reg-name))                       ;

(define (allocate-register name)
  (if (assoc name register-table)
      (error "Multiple defined register: " name)
      (begin (add stack name)                  ; add reg stack
             (set! register-table
                   (cons (list name (make-register name))
                         register-table))))
  'register-allocated)

.....


(define (make-save inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name)))
      (lambda ()
        (push stack (cons reg-name (get-contents reg)))
        (advance-pc pc)))))

(define (make-restore inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name)))
      (lambda ()
        (set-contents! reg (pop stack reg-name))
        (advance-pc pc)))))