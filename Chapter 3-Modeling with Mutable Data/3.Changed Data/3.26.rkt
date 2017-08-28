(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (search-tree given-key tree)
  (if (null? tree)
      false
      (let ((set-entry (entry tree)))
        (cond ((equ? given-key (key set-entry))
               set-entry)
              ((less? given-key (key set-entry))
               (search-tree given-key (left-branch tree)))
              ((greater? given-key (key set-entry))
               (search-tree given-key (right-branch tree)))
              (else
               (error "wrong key type" given-key))))))

;;define equ?
;;define greater?
;;define less?

(define (make-table)
  ; ((key . value) left-branch rignt-branch)
  (let ((local-table (list '*table*)))
    ; use assignment instead of return a brand new table
    (define (adjoin-table pair table)
      (if (null? (cdr table))
          (set-cdr! table (make-tree pair '() '()))
          (let ((tree (cdr table))
                (key (car pair)))
            (let ((entry-pair (entry tree)))
              (cond ((equ? key (car entry-pair))
                     (set-car! table pair))
                    ((less? key (car entry-pair))
                     (adjoin-table pair (left-branch tree)))
                    ((greater? key (car entry-pair))
                     (adjoin-table pair (right-branch tree)))
                    (else
                     (error "Wrong type of key" (list pair))))))))
    
    (define (generic-lookup op init key-list)
      (define (iter table keys)
        (cond ((null? table) #f)
              ((null? keys) table)
              (else
               (let ((subtable (search-tree (car keys) (cdr table))))
                 (if subtable
                     (iter subtable (cdr keys))
                     (iter (op (car keys) table)
                           (cdr keys)))))))
      (if (null? key-list)
          (error "need at least one key")
          (iter init key-list)))
    
    (define (lookup key-list)
      (generic-lookup (lambda (key table) '())
                      local-table
                      key-list))
    
    (define (insert! key-list value)
      (define (create-new key table)
        (let ((new-pair (cons key '())))
          (adjoin-table key value table)
          new-pair))
      (set-cdr! (generic-lookup create-new local-table key-list)
                value)
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else
             (error "Unaccepted request -- MAKE-TABLE" m))))

    dispatch))