(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (contents args))
          (error "No methods for these types"
                 (list op type-tags))))))

(define variable? symbol?)
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

;;dense part
(define (install-dense-package)
  ;;internal procedures
  (define (make-from-coeff var coeff-list)
    (cons var coeff-list))
  (define (make-from-term var term-list)
    (cons car (term->coeff term-list)))

  (define (coeff->term coeff-list)
    (if (null? coeff-list)
        '()
        (let ((t (first-term coeff-list)))
          (if (=zero? (coeff t))
              (coeff->term (rest-coeffs coeff-list))
              (cons t (coeff->term (rest-coeffs coeff-list)))))))

  (define (term->coeff term-list)
    (define (helper current-order term-list)
      (if (null? term-list)
          (if (> 0 current-order)
              '()
              (cons 0 (helper (- current-order 1) term-list)))
          (let ((t (car term-list)))
            (if (= (order t) current-order)
                (cons (coeff t)
                      (helper (- current-order 1) (cdr term-list)))
                (cons 0
                      (helper (- current-order 1) term-list))))))
    (helper (order (car term-list)) term-list))
  
  (define (variable p) (car p))
  (define (coeff-list p) (cdr p))
  (define (term-list p) (coeff->term (coeff-list p)))    

  (define (the-empty-coefflist) '())
  (define (first-term coeff-list)
    (make-term (- (length coeff-list) 1)
               (car coeff-list)))
  (define (rest-coeffs coeff-list) (cdr coeff-list))
  (define (empty-coefflist? coeff-list) (null? coeff-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (adjoin-term term coeff-list)
    (if (=zero? (coeff term))
        coeff-list
        (let ((t (first-term coeff-list)))
          (cond ((> (order term) (order t))
                 (if (= 1 (- (order term) (order t)))
                     (cons (coeff term) coeff-list)
                     (adjoin-term term (cons 0 coeff-list))))
                ((< (order term) (order t))
                 (cons (car coeff-list)
                       (adjoin-term term (rest-coeffs coeff-list))))
                (else
                 (cons (add (coeff term) (car coeff-list))
                       (rest-coeffs coeff-list)))))))

  ;;the similiar part of selection functions
  (define (add-terms L1 L2)
    (cond ((empty-coefflist? L1) L2)
          ((empty-coefflist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-coeffs L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-coeffs L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-coeffs L1)
                                (rest-coeffs L2)))))))))

  (define (mul-terms L1 L2)
    (if (empty-coefflist? L1)
        (the-empty-coefflist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-coeffs L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-coefflist? L)
        (the-empty-coefflist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-coeffs L))))))
  
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (coeff-list p1)
                              (coeff-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (coeff-list p1)
                              (coeff-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))

  ;;interface to rest of the system
  (define (tag p) (attach-tag 'dense p))
  (put 'variable 'dense
       (lambda (p) (variable p)))
  (put 'coeff-list 'dense
       (lambda (p) (coeff-list p)))
  (put 'term-list 'dense
       (lambda (p) (term-list p)))
  (put 'add '(dense dense)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(dense dense)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make-from-coeff 'dense
       (lambda (c) (tag (make-from-coeff c))))
  (put 'make-from-term 'dense
       (lambda (t) (tag (make-from-term t))))
  'done)

;;sparse part
(define (install-sparse-package)
  (define (make-from-coeff var coeff-list)
    (cons var (coeff->term coeff-list)))
  (define (make-from-term var term-list)
    (cons var term-list))

  (define (coeff->term coeff-list)
    (if (null? coeff-list)
        '()
        (let ((t (make-term (- (length coeff-list) 1)
                            (car coeff-list))))
          (if (=zero? (coeff t))
              (coeff->term (cdr coeff-list))
              (cons t (coeff->term (cdr coeff-list)))))))
  
  (define (term->coeff term-list)
    (define (helper current-order term-list)
      (if (null? term-list)
          (if (> 0 current-order)
              '()
              (cons 0 (helper (- current-order 1) term-list)))
          (let ((t (first-term term-list)))
            (if (= (order t) current-order)
                (cons (coeff t)
                      (helper (- current-order 1)
                              (rest-terms term-list)))
                (cons 0
                      (helper (- current-order 1) term-list))))))
    (helper (order (first-term term-list)) term-list))
  
  (define (variable p) (car p))
  (define (coeff-list p) (term->coeff (term-list p)))
  (define (term-list p) (cdr p))    

  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? termlist) (null? termlist))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (let ((t (first-term term-list)))
          (cond ((> (order term) (order t))
                 (cons term (term-list)))
                ((< (order term) (order t))
                 (cons t (adjoin-term term (rest-terms term-list))))
                (else
                 (cons (make-term (order term)
                                  (add (coeff term) (coeff t)))
                       (rest-terms term-list)))))))

  ;;the similiar part of selection functions
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))
  
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))

  ;;interface to rest of the system
  (define (tag p) (attach-tag 'sparse p))
  (put 'variable 'sparse
       (lambda (p) (variable p)))
  (put 'coeff-list 'sparse
       (lambda (p) (coeff-list p)))
  (put 'term-list 'sparse
       (lambda (p) (term-list p)))
  (put 'add '(sparse sparse)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(sparse sparse)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make-from-coeff 'sparse
       (lambda (c) (tag (make-from-coeff c))))
  (put 'make-from-term 'sparse
       (lambda (t) (tag (make-from-term t))))
  'done)

(define (add-poly p1 p2) (apply-generic 'add p1 p2))
(define (mul-poly p1 p2) (apply-generic 'mul p1 p2))

(define (make-from-coeff var coeff-list)
  ((get 'make-from-coeff 'dense) var coeff-list))

(define (make-from-term var term-list)
  ((get 'make-from-term 'sparse) var term-list))