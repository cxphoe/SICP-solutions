;; use the solution of question 3.25
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (general-lookup op init . seq)
      ;;the result of this proc is depended on the op
      ;;for lookup or insert!
      (define (iter res key-list)
        (if (null? key-list)
            res
            (iter (op (car key-list) res)
                  (cdr key-list))))
      (iter init seq))
    
    (define (lookup key1 key2)
      (define (sub-lookup key records)
        (if records
            (let ((record (assoc key records)))
              (if record
                  (cdr record)
                  false))
            false))
      (general-lookup sub-lookup (cdr local-table) key1 key2))

    (define (insert! key1 key2 value)
      (define (sub-insert key table)
        (let ((record (assoc key (cdr table))))
          (or record
              (let ((new-rear (cons (list key)
                                    (cdr table))))
                ;;create a new subtable and return it
                (set-cdr! table new-rear)
                (car new-rear)))))
      (set-cdr! (general-lookup sub-insert local-table key1 key2)
                value)
      'ok)

    (define (print) 
      (define (indent tabs)
        (if (> tabs 0)
            (begin (display "    ")
                   (indent (- tabs 1)))))
  
      (define (print-record rec level) 
        (indent level) 
        (display (car rec)) 
        (display ": ") 
        (if (list? rec) 
            (begin (newline) 
                   (print-table rec (+ 1 level))) 
            (begin (display (cdr rec)) 
                   (newline)))) 
              
      (define (print-table table level) 
        (if (null? (cdr table)) 
            (begin (display "-no entries-") 
                   (newline)) 
            (for-each (lambda (record) 
                        (print-record record level)) 
                      (cdr table)))) 
  
      (print-table local-table 0))
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'print) print)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define op-table (make-table))
(define put (op-table 'insert-proc!))
(define get (op-table 'lookup-proc))

(define (variable? x) (symbol? x))

(define (install-eval-package)
  (put 'eval 'assignment (lambda (exp env) (eval-assignment exp env)))
  (put 'eval 'definition (lambda (exp env) (eval-definition exp env)))
  (put 'eval 'if (lambda (exp env) (eval-if exp env)))
  (put 'eval 'lambda (lambda (exp env)
                       (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env)))
  (put 'eval 'begin (lambda (exp env)
                      (eval-sequence (begin-actions exp) env)))
  (put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env)))
  'ok)

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((get 'eval (car exp))
         ((get 'eval (car exp)) exp env))
        ((application? exp) (apply (eval (operator exp) env)
                                   (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))

(install-eval-package)