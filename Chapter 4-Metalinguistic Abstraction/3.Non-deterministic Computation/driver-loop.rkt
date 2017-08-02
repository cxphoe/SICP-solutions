(load "analyze.rkt")
(load "environment.rkt")

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '+ +)
        (list '* *)
        (list '- -)
        (list '/ /)
        (list '= =)
        (list '> >)
        (list '< <)
        (list '<= <=)
        (list '>= >=)
        (list 'even? even?)
        (list 'odd? odd?)
        (list 'not not)
        (list 'display display)
        (list 'runtime runtime)))

(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

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

(driver-loop)