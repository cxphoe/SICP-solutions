(load "analyze.rkt")
(load "environment.rkt")

(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline)
            (display ";;; Starting a new problem ")
            (ambeval input
                     the-global-environment
                     ;; ambeval success
                     (lambda (val next-alternative)
                       ;; succeed take two parameters: value and fail.
                       ;; So the interval-loop will call fail to get
                       ;; another value or end up with no values.(fail
                       ;; is a procedure trying get values from other
                       ;; process)
                       (announce-output output-prompt)
                       (user-print val)
                       (internal-loop next-alternative))
                     ;; ambeval failure
                     ;; This is the basic fail procedure, would be passed
                     ;; as the fail procedure of process in most cases.
                     ;; But when it hits amb procedure it will be kept in
                     ;; a local procedure of the result returned by anal-
                     ;; yze-amb. After that, the fail procedure passed in
                     ;; the process woulb be the next value of amb-choices.
                     ;; And this basic fail procedure won't be released,
                     ;; until the amb-choices is run out.
                     (lambda ()
                       (announce-output
                        ";;; There are no more values of")
                        (user-print input)
                        (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)))
      (display object)))

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))

;; for queen (question 4.44)
(define (built-in-define text)
  (ambeval text
           the-global-environment
           (lambda (val next)
             (user-print val))
           (lambda ()
             (announce-output
              ";;; fail to define"))))


(built-in-define '(define (safe-row? row1 row2)
                    (not (= row1 row2))))

(built-in-define '(define (safe-diagonal? row1 row2 col1 col2)
                    (not (= (- col2 col1)
                            (abs (- row2 row1))))))

(built-in-define '(define (list-ref seq n)
                    (if (= n 0)
                        (car seq)
                        (list-ref (cdr seq) (- n 1)))))

(built-in-define '(define (safe? k positions)
                    (let ((kth-row (list-ref positions (- k 1))))
                      (define (safe-iter p col)
                        (cond ((= col k) true)
                              ((and (safe-row? (car p) kth-row)
                                    (safe-diagonal? (car p) kth-row col k))
                               (safe-iter (cdr p) (+ col 1)))
                              (else false)))
                      (safe-iter positions 1))))

(built-in-define '(define (list-amb li)
                    (if (null? li)
                        (amb)
                        (amb (car li) (list-amb (cdr li))))))

(built-in-define '(define (enumerate-interval low high)
                    (if (> low high)
                        '()
                        (cons low (enumerate-interval (+ low 1) high)))))

(built-in-define '(define (queen board-size)
                    (define (queen-iter k positions)
                      (if (= k board-size)
                          positions
                          (let ((row (list-amb (enumerate-interval 1 board-size))))
                            (let ((new-pos (append positions (list row))))
                              (require (safe? k new-pos))
                              (queen-iter (+ k 1) new-pos)))))
                    (queen-iter 1 '())))

(driver-loop)