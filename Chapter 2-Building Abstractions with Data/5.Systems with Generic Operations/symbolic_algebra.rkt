(define (attach-tag tag x)
  (if (number? x)
      x
      (cons tag x)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-args)))
      (if proc
          (apply proc (contents args))
          (error "No method for these types"
                 (list op type-tags))))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

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

(define (install-polynomial-package)
  ;;internal procedures
  ;;representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  (define (variable? x) (symbol? x))
  (define (same-variable? x y)
    (and (variable? x) (variable? y) (eq? x y)))

  ;;representation of terms and term lists
  (define (adjoin-term term term-list)
    (define (helper rest-of-list)
      (if (null? rest-of-list)
          term
          (let ((t (first-term rest-of-list)))
            (let ((o1 (order term))
                  (o2 (order t)))
              (cond ((> o1 o2)
                     (cons term rest-of-list))
                    ((< o1 o2)
                     (cons t (helper (rest-terms rest-of-list))))
                    (else
                     (cons (make-term o1 (+ (coeff term) (coeff t)))
                           rest-of-list)))))))
    (if (=zero? (coeff term))
        term-list
        (helper term-list)))
  
  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))
  
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
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list (the-empty-termlist) L1)
              (let ((new-c (div (coeff t1) (coeff t2)))
                    (new-o (- (order t1) (order t2))))
                (let ((rest-of-result
                       (div-terms
                        (add-terms L1
                                   (mul-terms (list (make-term 0 -1))
                                              (mul-terms (list (make new-o new-c))
                                                         L2)))
                        L2)))
                  (cons (adjoin-term (make-term new-o new-c)
                                     (car rest-of-result))
                        (cdr rest-of-result))))))))
  
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-term (term-list p1)
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
                   (mul-term (term-list p1)
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

  ;;interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add 'term
       (lambda (l1 l2) (add-terms l1 l2)))
  (put 'sub 'term
       (lambda (l1 l2) (sub-terms l1 l2)))
  (put 'mul 'term
       (lambda (l1 l2) (mul-terms l1 l2)))
  (put 'div 'term
       (lambda (l1 l2) (div-terms l1 l2)))
  
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (tag (div-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

(define (install-rational-package)
  ;;internal procedures
  ;;representation of rational poly
  (define (add-terms L1 L2) ((get 'add 'term) L1 L2))
  (define (sub-terms L1 L2) ((get 'sub 'term) L1 L2))
  (define (mul-terms L1 L2) ((get 'mul 'term) L1 L2))
  (define (div-terms L1 L2) ((get 'div 'term) L1 L2))
  
  (define (make-rat n d)
    (let ((g (gcd-poly n d)))
      (cons (div n g) (div d g))))

  (define (gcd-terms a b)
    (if (empty-termlist? b)
        a
        (gcd-terms b (remainder-terms a b))))
  
  (define (remainder-terms a b)
    (cadr (div-terms a b)))
    
  (define (gcd-poly p1 p2)
    (let ((v1 (variable p1))
          (v2 (variable p2))
          (t1 (term-list p1))
          (t2 (term-list p2)))
      (if (same-variable? v1 v2)
          (gcd-terms t1 t2)
          (error "Polys not in same var -- GCD-POLY"
                 (list p1 p2)))))

  (define (numer r) (car (term-list r)))
  (define (denom r) (cdr (term-list r)))

  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  (define variable? symbol?)
  (define (same-variable? x y)
    (and (variable? x) (variable? y) (eq? x y)))

  (define (add-rat r1 r2)
    (if (same-variable? (variable r1) (variable r2))
        (make-rat (add-terms (mul-terms (numer r1) (denom r2))
                             (mul-terms (numer r2) (denom r1)))
                  (mul-terms (denom r1) (denom r2)))
        (error "Rational not in sam var -- ADD-RAT"
               (list r1 r2))))

  ;;interface to rest of system
  (define (tag r) (attach-tag 'rational r))
  (put 'gcd-poly '(polynomial polynomial)
       (lambda (x y) (tag (gcd-poly x y))))
  
  (put 'make 'rational
       (lambda (x y) (tag (make-rat x y))))
  (put 'numer 'rational
       (lambda (r) (numer r)))
  (put 'denom 'rational
       (lambda (r) (denom r)))
  (put 'add '(rational rational)
       (lambda (r1 r2) (tag (add-rational r1 r2))))
  'done)
  
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))
(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (numer r) ((get 'numer 'rational) r))
(define (denom r) ((get 'denom 'rational) r))

(define (type-tag x)
  (if (number? x)
      'scheme-number
      (car x)))

(define (install-greatest-common-divisor-package)
  (define gcd-poly
    (get 'gcd-poly '(polynomial polynomial)))

  (put 'gcd '(polynomial polynomial)
       (lambda (x y) (gcd-poly x y)))
  (put 'gcd '(shceme-number shceme-number)
       (lambda (x y) (gcd x y)))
  'done)

(define (greatest-common-divisor x y)
  ((get 'gcd (map type-tag (list x y))) x y))