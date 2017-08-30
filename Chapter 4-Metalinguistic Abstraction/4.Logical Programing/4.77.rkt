(define (filter? exp)
  (or (list-value? exp)
      (not? exp)))

(define (conjoin conjuncts frame-stream)
  (conjoin-mix conjuncts '() frame-stream))

(define (conjoin-mix conjs delayed-conjs frame-stream)
  (if (null? conjs)
      (if (null? delayed-conjs)
          frame-stream          ; conjoin finish if both of conjuncts are empty
          the-empty-stream)     ; no result return cause filters with unbound vars exist
      (let ((first (first-conjunct conjs))
            (rest (rest-conjuncts conjs)))
        (if (filter? first)
            (let ((check-result
                   (conjoin-check first delayed-conjs frame-stream)))
              (conjoin-mix rest
                           (car check-result)
                           (cdr check-result)))
            (let ((new-frame-stream (qeval first frame-stream)))
              (let ((delayed-result
                     (conjoin-delayed delayed-conjs '() new-frame-stream)))
                (conjoin-mix rest (car delayed-result) (cdr delayed-result))))))))

(define (conjoin-delayed delayed-conjs rest-conjs frame-stream)
  ; evaluate those conjuncts in delayed-conjs if there are
  ; enough bindings for them.
  (if (null? delayed-conjs)
      (cons rest-conjs frame-stream)
      (let ((check-result
             (conjoin-check (first-conjunct delayed-conjs)
                            rest-conjs frame-stream)))
        (conjoin-delayed (cdr delayed-conjs)
                         (car check-result)
                         (cdr check-result)))))

(define (conjoin-check target conjs frame-stream)
  ; Check if there are any unbound vars in target.
  ; Delay it if there are unbound vars, or just evaluate it.
  (if (has-unbound-var? (contents target) (stream-car frame-stream))
      (cons (cons target conjs) frame-stream)
      (cons conjs (qeval target frame-stream))))

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