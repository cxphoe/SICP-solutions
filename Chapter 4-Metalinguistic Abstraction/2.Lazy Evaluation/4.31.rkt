;; the expression of lazy and lazy-memo
(define (lazy-parameter? p)
  (and (pair? p) (eq? (cadr p) 'lazy) (null? (cddr p))))

(define (lazy-memo-parameter? p)
  (and (pair? p) (eq? (cadr p) 'lazy-memo) (null? (cddr p))))

(define (lazy? obj)
  (tagged-list? obj 'lazy))

(define (lazy-memo? obj)
  (tagged-list? obj 'lazy-memo))

(define (eval-lazy-memo? obj)
  (tagged-list? obj 'eval-lazy-memo))

(define (delay-lazy exp env)
  (list 'lazy exp env))

(define (delay-lazy-memo exp env)
  (list 'lazy-memo exp env))

(define (force-it obj)
  (cond ((lazy? obj)
         (actual-value (thunk-exp obj) (thunk-env obj)))
        ((lazy-memo? obj)
         (let ((result (actual-value (thunk-exp obj)
                                     (thunk-env obj))))
           (set-car! obj 'eval-lazy-memo)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((eval-lazy-memo? obj)
         (thunk-value obj))
        (else obj)))

(define (actual-value exp env)
  (force-it (eval exp env)))

;; change some details
(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (let ((parameters (procedure-parameters procedure)))
           (eval-sequence
            (procedure-body procedure)
            (extend-environment
             (rib-statements parameters)                     ; changed
             (list-of-delayed-args parameters arguments env) ;
             (procedure-environment procedure)))))
        (else
         (error "Unknown procedure type -- APPLY" procedure))))

(define (rib-statements parameters)
  (if (null? parameters)
      '()
      (let ((first (car parameters)) (rest (cdr parameters)))
        (cond ((or (lazy-parameter? first)
                   (lazy-memo-parameter? first))
               (cons (car first) (rib-statements rest)))
              ((variable? first)
               (cons first (rib-statements rest)))
              (else
               (error "Bad Syntax" first))))))

(define (list-of-delayed-args paras exps env)                ; changed
  (if (no-operands? exps)
      '()
      (cons (cond ((lazy-parameter? (car paras))
                   (delay-lazy (first-operand exps) env))
                  ((lazy-memo-parameter? (car paras))
                   (delay-lazy-memo (first-operand exps) env))
                  (else
                   (eval (first-operand exps) env)))
            (list-of-delayed-args (cdr paras) (rest-operands exps) env))))