(load "expression.rkt")
(load "record-operation.rkt")

;; evaluator for amb
(define (ambeval exp succeed fail frame)
  ((analyze exp frame) succeed fail))

(define (analyze exp frame)
  (cond ((assertion-to-be-added? exp) (update-data exp))
        ((and? exp) (conjoin (contents exp) frame))
        ((or? exp) (disjoin (contents exp) frame))
        ((not? exp) (negate (contents exp) frame))
        ((lisp-value? exp) (lisp-value (contents exp) frame))
        ((unique? exp) (uniquely-asserted (contents exp) frame))
        ((always-true? exp) (always-true (contents exp) frame))
        ((query? exp) (simple-query exp frame))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (update-data exp)
  (add-rule-or-assertion! (add-assertion-body q))
  (newline)
  (display "Assertion added to data base."))

;; simple query
(define (simple-query query-pattern frame)
  (lambda (succeed fail)
    ((find-assertions query-pattern frame)
     succeed
     (lambda ()
       ((apply-rules query-pattern frame)
        succeed
        fail)))))

;; for assertions
(define (find-assertions pattern frame)
  (let ((records (fetch-assertions pattern frame)))
    (lambda (succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((check-an-assertion (car choices)
                                 pattern
                                 frame)
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next records))))

(define (check-an-assertion assertion query-pat query-frame)
  (lambda (succeed fail)
    (let ((match-result
           (pattern-match query-pat assertion query-frame)))
      (if (eq? match-result 'failed)
          (fail)
          (succeed match-result fail)))))

(define (pattern-match pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match (cdr pat)
                        (cdr dat)
                        (pattern-match (car pat)
                                       (car dat)
                                       frame)))
        (else 'failed)))

(define (extend-if-consistent var dat frame)
  (let ((binding (binding-in-frame var frame)))
    (if binding
        (pattern-match (binding-value binding) dat frame)
        (extend var dat frame))))

;; for rules
(define (apply-rules pattern frame)
  (let ((rules (fetch-rules pattern frame)))
    (lambda (succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((apply-a-rule (car choices)
                           pattern
                           frame)
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next rules))))

(define (apply-a-rule rule query-pattern query-frame)
  (let ((clean-rule (rename-variables-in rule)))
    (let ((unify-result
           (unify-match query-pattern
                        (conclusion clean-rule)
                        query-frame)))
      (lambda (succeed fail)
        (if (eq? unify-result 'failed)
            (fail)
            ((analyze (rule-body clean-rule) unify-result)
             succeed
             fail))))))

(define (rename-variables-in rule)
  (let ((rule-application-id (new-rule-application-id)))
    (define (tree-walk exp)
      (cond ((var? exp)
             (make-new-variable exp rule-application-id))
            ((pair? exp)
             (cons (tree-walk (car exp))
                   (tree-walk (cdr exp))))
            (else exp)))
    (tree-walk rule)))

(define (unify-match p1 p2 frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? p1 p2) frame)
        ((var? p1) (extend-if-possible p1 p2 frame))
        ((var? p2) (extend-if-possible p2 p1 frame))  ; ***
        ((and (pair? p1) (pair? p2))
         (unify-match (cdr p1)
                      (cdr p2)
                      (unify-match (car p1)
                                   (car p2)
                                   frame)))
        (else 'failed)))

(define (extend-if-possible var val frame)
  (let ((binding (binding-in-frame var frame)))
    (cond (binding
           (unify-match
            (binding-value binding) val frame))
          ; var has no binding check if val is variable.
          ((var? val)
           (let ((binding (binding-in-frame val frame)))
             (if binding
                 ; check if var and binding are matched
                 (unify-match
                  var (binding-value binding) frame)
                 ; bind var to val if both of them are variable
                 (extend var val frame))))
          ; check if var itself is in val
          ((depends-on? val var frame)
           'failed)
          (else (extend var val frame)))))

(define (depends-on? exp var frame)
  (define (tree-walk e)
    (cond ((var? e)
           (if (equal? var e)
               true
               (let ((b (binding-in-frame e frame)))
                 (if b
                     (tree-walk (binding-value b))
                     false))))
          ((pair? e)
           (or (tree-walk (car e))
               (tree-walk (cdr e))))
          (else false)))
  (tree-walk exp))

;; compound query
;;;; and
(define (conjoin conjuncts frame)
  (lambda (succeed fail)
    (let ((first (analyze (car conjuncts) frame)))
      (if (null? (cdr conjuncts))
          (first succeed fail)
          (first (lambda (conj1-value fail2)
                   ((conjoin (cdr conjuncts) conj1-value)
                    succeed
                    fail2))
                 fail)))))

;;;; or
(define (disjoin disjuncts frame)
  (lambda (succeed fail)
    (define (try-next choices)
      (if (null? choices)
          (fail)
          ((analyze (car choices) frame)
           succeed
           (lambda ()
             (try-next (cdr choices))))))
    (try-next disjuncts)))

;; filter
;;;; not
(define (negate operands frame)
  (lambda (succeed fail)
    ((analyze (negated-query operands) frame)
     (lambda (val fail2)
       (fail))
     (lambda ()
       (succeed frame fail)))))

;;;; lisp-value
(define (lisp-value call frame)
  (lambda (succeed fail)
    (if (execute
         (instantiate call frame (lambda (v f)
                                   (error "Unknown pat var -- LISP-VALUE"
                                          v))))
        (succeed frame fail)
        (fail))))

;; procedure execute based on the basic eval system
(define (execute exp)
  (apply (eval (predicate exp) user-initial-environment)
         (args exp)))

;; always true for no-body query
(define (always-true ignore frame)
  (lambda (succeed fail)
    (succeed frame fail)))

;; unique !!!!!! to be improved
(define (uniquely-asserted operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (let ((res-f (qeval (unique-query operands)
                         (singleton-stream frame))))
       (if (single-stream? res-f)
           res-f
           the-empty-stream)))
   frame-stream))

