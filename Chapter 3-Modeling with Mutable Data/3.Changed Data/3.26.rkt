(define (make-table)
  (let ((local-table (list '*table*)))
    ;;define bigger?
    ;;define smaller?
    
    (define (search-tree given-key tree)
      (if (null? tree)
          false
          (let ((tree-entry (car tree)))
            (cond ((equal? given-key (key tree-entry))
                   tree-entry)
                  ((bigger? given-key (key tree-entry))
                   (search-tree given-key (right-branch tree)))
                  ((smaller? given-key (key tree-entry))
                   (search-tree given-key (left-branch tree)))
                  (else
                   (error "wrong key type" given-key))))))

    (define (adjoin-tree given-key value tree)
      (let ((entry-tree (entry tree)))
        (cond ((smaller? given-key (key entry-tree))
               (if (null? (left-brach tree))
                   (set-car! (cdr tree) (list (cons given-key value)
                                              '()
                                              '()))
                   (adjoin-tree given-key value (left-branch tree))))
              ((bigger? given-key (key entry-tree))
               (if (null? (right-branch tree))
                   (set-car! (cddr tree) (list (cons given-key value)
                                               '()
                                               '()))
                   (adjoin-tree given-key value (right-branch tree))))
              (else
               (error "Wrong key type -- ADJOIN-TREE" given-key)))))

    (define (adjoin-table key-list value tree)
      (define (create-new key-list value)
        (if (null? (cdr key-list))
            (cons (car key-list) value)
            (list (cons (car key-list)
                        (create-new (cdr key-list) value))
                  '()
                  '())))
      (adjoin-tree (car key-list)
                   (create-new (cdr key-list) value)
                   tree))
    
    (define (lookup key-list)
      (define (iter-lookup key-list table)
        (cond ((= 1 (length key-list))
               (let ((record (search-tree (car key-list) (cdr table))))
                 (if record
                     (cdr record)
                     false)))
              (else
               (let ((subtable (search-tree (car key-list) (cdr table))))
                 (if subtable
                     (iter-lookup (cdr key-list) subtable)
                     false)))))
      (iter-lookup key-list local-table))

    (define (insert! key-list value)
      (define (iter-lookup key-list table)
        (cond ((= 1 (length key-list))
               (let ((record (search-tree (car key-list) (cdr table))))
                 (if record
                     (set-cdr! record value)
                     (adjoin-tree key value (cdr table)))))
              (else
               (let ((subtable (search-tree (car key-list) (cdr table))))
                 (if subtable
                     (iter-lookup (cdr key-list) subtable)
                     (adjoin-table key-list value (cdr table)))))))
      (if (null? key-list)
          (error "NEED at least one key -- INSERT!" key-list)
          (iter-lookup key-list local-table)))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else
             (error "Unaccepted request -- MAKE-TABLE" m))))

    dispatch))