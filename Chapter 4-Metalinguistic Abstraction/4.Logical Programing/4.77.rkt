(define (conjoin conjuncts frame-stream)
  (conjoin-mix conjuncts '() frame-stream))

(define (conjoin-mix conjs delayed-conjs frame-stream)
  (if (null? conjs)
      (if (null? delayed-conjs)
          frame-stream          ; conjoin finish if both of conjuncts are empty
          the-empty-stream)     ; no result return cause filters with unbound vars exist
      (let ((first (first-conjunct conjs)))
        (cond ((or (lisp-value? first) (not? first))
               ; Check if there are any unbound vars if clause is a filter.
               ; Delay it if there are unbound vars, or just evaluate it.
               (if (has-unbound-var? (contents first)
                                     (stream-car frame-stream))
                   (conjoin-mix (rest-conjuncts conjs)
                                (cons first delayed-conjs)
                                frame-stream)
                   (conjoin-mix (rest-conjuncts conjs)
                                delayed-conjs
                                (qeval first frame-stream))))
              ; Just evaluate the clause if it's not a filter
              (else
               (let ((new-frame-stream (qeval first frame-stream)))
                 ; Check if there are delayed conjuncts.
                 ; -- If there are, check if the existed bindings are enough
                 ;    for them.
                 ; -- If there are not, just move to the next recursion.
                 (if (null? delayed-conjs)
                     (conjoin-mix (rest-conjuncts conjs)
                                  '()
                                  new-frame-stream)
                     (let ((res (conjoin-delayed delayed-conjs
                                                 '()
                                                 new-frame-stream)))
                       (let ((d-conjs (car res))
                             (f-stream (cdr res)))
                         (conjoin-mix (rest-conjuncts conjs)
                                      d-conjs
                                      f-stream))))))))))
      
(define (conjoin-delayed delayed-conjs rest-conjs frame-stream)
  (if (null? delayed-conjs)
      (cons rest-conjs frame-stream)
      (let ((first (first-conjunct delayed-conjs)))
        (if (has-unbound-var? first (stream-car frame-stream))
            (conjoin-delayed (cdr delayed-conjs)
                             (cons first rest-conjs)
                             frame-stream)
            (conjoin-delayed (cdr delayed-conjs)
                             rest-conjs
                             (qeval first frame-stream))))))

(define (has-unbound-var? exp frame)
  (define (tree-walk exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (tree-walk (binding-value binding))
                 true)))
          ((pair? exp)
           (or (tree-walk (car exp)) (tree-walk (cdr exp))))
          (else false)))
  (tree-walk exp))