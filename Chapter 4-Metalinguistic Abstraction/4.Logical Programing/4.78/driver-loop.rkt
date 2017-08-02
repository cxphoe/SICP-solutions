(load "evaluator.rkt")
(load "environment.rkt")

(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (copy (binding-value binding))
                 (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (query-syntax-process (read))))
      (cond ((assertion-to-be-added? input)
             (add-rule-or-assertion! (add-assertion-body input))
             (newline)
             (display "Assertion added to data base.")
             (internal-loop try-again))
            ((eq? input 'try-again) (try-again))
            (else
             (begin
               (newline)
               (display ";;; Starting a new problem ")
               (ambeval input
                        ;; ambeval success
                        (lambda (val next-alternative)
                          ;; succeed take two parameters: value and fail.
                          ;; So the interval-loop will call fail to get
                          ;; another value or end up with no values.(fail
                          ;; is a procedure trying get values from other
                          ;; process)
                          (let ((res (instantiate
                                       input
                                       val
                                       (lambda (v f)
                                         (contract-question-mark v)))))
                            (announce-output output-prompt)
                            (display res)
                            (internal-loop next-alternative)))
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
                          (display input)
                          (driver-loop))
                        '()))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))
  
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(add-rule-or-assertion! '(address (bitdiddle ben) (slumerville (ridge road) 10)))
(add-rule-or-assertion! '(job (bitdiddle ben) (computer wizard)))
(add-rule-or-assertion! '(salary (bitdiddle ben) 60000))

(add-rule-or-assertion! '(address (hacker alyssa p) (cambridge (mass ave) 78)))
(add-rule-or-assertion! '(job (hacker alyssa p) (computer programmer)))
(add-rule-or-assertion! '(salary (hacker alyssa p) 40000))
(add-rule-or-assertion! '(supervisor (hacker alyssa p) (bitdiddle ben)))

(add-rule-or-assertion! '(address (fect cy d) (cambridge (ames street) 3)))
(add-rule-or-assertion! '(job (fect cy d) (computer programmer)))
(add-rule-or-assertion! '(salary (fect cy d) 35000))
(add-rule-or-assertion! '(supervisor (fect cy d) (bitdiddle ben)))

(add-rule-or-assertion! '(address (tweakit lem e) (boston (bay state road) 22)))
(add-rule-or-assertion! '(job (tweakit lem e) (computer technician)))
(add-rule-or-assertion! '(salary (tweakit lem e) 25000))
(add-rule-or-assertion! '(supervisor (tweakit lem e) (bitdiddle ben)))

(add-rule-or-assertion! '(address (reasoner louis) (slumerville (pine tree road) 80)))
(add-rule-or-assertion! '(job (reasoner louis) (computer programmer trainee)))
(add-rule-or-assertion! '(salary (reasoner louis) 30000))
(add-rule-or-assertion! '(supervisor (reasoner louis) (bitdiddle ben)))

(add-rule-or-assertion! '(supervisor (bitdiddle ben) (warbucks Oliver)))

(add-rule-or-assertion! '(address (warbucks oliver) (swellesley (top heap road))))
(add-rule-or-assertion! '(job (warbucks oliver) (administration big wheel)))
(add-rule-or-assertion! '(salary (warbucks oliver) 150000))

(add-rule-or-assertion! '(address (scrooge eben) (weston (shady lane) 10)))
(add-rule-or-assertion! '(hob (scrooge eben) (accounting chief accountant)))
(add-rule-or-assertion! '(salary (scrooge eben) 75000))
(add-rule-or-assertion! '(supervisor (scrooge eben) (warbucks oliver)))

(add-rule-or-assertion! '(address (cratchet robert) (allston (n harvard street) 16)))
(add-rule-or-assertion! '(job (cratchet robert) (accounting scrivener)))
(add-rule-or-assertion! '(salary (cratchet robert) 18000))
(add-rule-or-assertion! '(supervisor (cratchet robert) (scrooge eben)))

(add-rule-or-assertion! '(address (aull dewitt) (slumerville (onion square) 5)))
(add-rule-or-assertion! '(job (aull dewitt) (administration secretary)))
(add-rule-or-assertion! '(salary (aull dewitt) 25000))
(add-rule-or-assertion! '(supervisor (aull dewitt) (warbucks oliver)))

(add-rule-or-assertion! '(can-do-job (computer wizard) (computer programmer)))
(add-rule-or-assertion! '(can-do-job (computer wizard) (computer technician)))
(add-rule-or-assertion! '(can-do-job (computer programmer)
                                     (computer programmer trainee)))

(add-rule-or-assertion! '(can-do-job (administration secretary)
                                     (administration big wheel)))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (lives-near ?person-1 ?person-2)
                                (and (address ?person-1 (?town . ?rest-1))
                                     (address ?person-2 (?town . ?rest-2))
                                     (not (same ?person-1 ?person-2))))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (same ?x ?x))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (append-to-form () ?y ?y))))
(add-rule-or-assertion! (query-syntax-process
                         '(rule (append-to-form (?u . ?v) ?y (?u . ?z))
                                (append-to-form ?v ?y ?z))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (last-pair (?x) ?x))))
(add-rule-or-assertion! (query-syntax-process
                         '(rule (last-pair (?v . ?z) ?x)
                                (last-pair ?z ?x))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (reverse () ()))))
(add-rule-or-assertion! (query-syntax-process
                         '(rule (reverse (?x . ?y) ?z)
                                (and (reverse ?y ?v)
                                     (append-to-form ?v (?x) ?z)))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (all-supervisors ?p1 ?p2)
                                (or (supervisor ?p1 ?p2)
                                    (and (supervisor ?p1 ?p)
                                         (all-supervisors ?p ?p2))))))

(add-rule-or-assertion! (query-syntax-process
                         '(rule (staff-with-one-supervisor ?p1 ?p2)
                                (and (or (supervisor ?p1 ?p2)
                                         (and (supervisor ?p1 ?p3)
                                              (supervisor ?p3 p2)))
                                     (unique (all-supervisors ?p1 ?p))))))
   


(driver-loop)