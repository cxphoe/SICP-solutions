;;basic defination not installed by a package
(define (make-poly var terms) (cons var terms))
(define (variable p) (car p))
(define (term-list p) (cdr p))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define variable? symbol?)

(define (the-empty-termlist) '())
(define empty-termlist? null?)

(define (first-term L) (car L))
(define (rest-terms L) (cdr L))

(define (make-term order coeff) (list order coeff))
(define order car)
(define coeff cadr)

(define (adjoin-term term term-list)
  (define (helper rest-of-list)
    (if (empty-termlist? rest-of-list)
        (list term)
        (let ((t (first-term rest-of-list)))
          (let ((o1 (order term))
                (o2 (order t)))
            (cond ((> o1 o2)
                   (cons term rest-of-list))
                  ((< o1 o2)
                   (cons t (helper (rest-terms rest-of-list))))
                  (else
                   (cons (make-term o1 (+ (coeff term) (coeff t)))
                         (rest-terms rest-of-list))))))))
  
  (if (=zero? (coeff term))
      term-list
      (helper term-list)))

(define (=zero? coe)
  (define (termlist=zero? L)
    (cond ((null? L) true)
          ((=zero? (coeff (first-term L)))
           (termlist=zero? (rest-terms L)))
          (else false)))
  
  (cond ((number? coe) (= coe 0))
        ((and (pair? coe) (variable? (car coe)))
         (termlist=zero? (term-list coe)))
        (else
         (error "Unknown type -- =ZERO?" coe))))

(define (gcd-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2))
        (t1 (term-list p1))
        (t2 (term-list p2)))
    (if (same-variable? v1 v2)
        (gcd-terms t1 t2)
        (error "Polys not in same var -- GCD-POLY"
               (list p1 p2)))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (remainder-terms a b)
  (cadr (div-terms a b)))

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
                              (+ (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1)
                              (rest-terms L2)))))))))

(define (sub-terms L1 L2)
  (define (convert L)
    (if (null? L)
        '()
        (let ((t (first-term L)))
          (cons (make-term (order t)
                           (mul (list (make-term 0 -1) (coeff t)))
                           (convert (rest-terms L)))))))
  (add-terms L1 (convert L2)))

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
                    (* (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (/ (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                     (div-terms
                      (add-terms L1
                                 (mul-terms (list (make-term 0 -1))
                                            (mul-terms (list (make-term new-o new-c))
                                                       L2)))
                      L2)))
                (cons (adjoin-term (make-term new-o new-c)
                                   (car rest-of-result))
                      (cdr rest-of-result))))))))

(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                           (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))

(define (sub-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (sub-term (term-list p1)
                           (term-list p2)))
      (error "Polys not in same var -- SUB-POLY"
             (list p1 p2))))

  
(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (div-term (term-list p1)
                           (term-list p2)))
      (error "Polys not in same var -- DIV-POLY"
             (list p1 p2))))

(define (add p1 p2) (add-poly p1 p2))
(define (sub p1 p2) (sub-poly p1 p2))
(define (mul p1 p2) (mul-poly p1 p2))
(define (div p1 p2) (div-poly p1 p2))


;;for question 2.95
(define p1 (make-poly 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-poly 'x '((2 11) (0 7))))
(define p3 (make-poly 'x '((1 13) (0 5))))

(define Q1 (mul p1 p2))
(define Q2 (mul p1 p3))

(define res (gcd-poly Q1 Q2))
;;the differences are from the procedure gcd-poly