(load "2.96.rkt")

;;a)
(define (reduce-terms n d)
  (let ((g (pseudoremainder-terms n d)))
    (let ((o1 (order (first-term n)))
          (o2 (order (first-term d)))
          (o3 (order (first-term g)))
          (c (coeff (first-term g))))
      (let ((factor (make-term 0
                               (expt c (- (+ 1 (max o1 o2)) o3)))))
        (let ((nn (car (div-terms (mul-terms n (list factor))
                                  g)))
              (dd (car (div-terms (mul-terms d (list factor))
                                  g))))
          (let ((g-coeff (apply gcd (map coeff (append n d)))))
            (let ((g-coe-term (make-term 0 g-coeff)))
              (list (car (div-terms nn (list g-coe-term)))
                    (car (div-terms dd (list g-coe-term)))))))))))

(define (reduce-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2))
        (t1 (term-list p1))
        (t2 (term-list p2)))
    (if (same-variable? v1 v2)
        (let ((sims (reduce-terms t1 t2)))
          (list (make-poly v1 (car sims))
                (make-poly v1 (cadr sims))))
        (error "Polys not in same var -- GCD-POLY"
               (list p1 p2)))))

;(display (reduce-poly Q1 Q2))

;;b)
(define (install-reduce-package)
  (define (reduce-integers n d)
    (let ((g (gcd n d)))
      (list (/ n g) (/ d g))))

  (put 'reduce '(scheme-number scheme-number)
       (lambda (x y) (reduce-integers x y)))
  (put 'reduce '(polynomial polynomial)
       (lambda (x y) (reduce-poly x y)))
  'done)

(define (reduce x y) (apply-generic 'reduce x y))

;;test
(define (make-rat-ori n d)
  (list n d))

(define (make-rat n d)
  (reduce-poly n d))

(define (numer r) (car r))
(define (denom r) (cadr r))

(define (add-rat-ori r1 r2)
  (make-rat-ori (add-poly (mul-poly (numer r1) (denom r2))
                          (mul-poly (numer r2) (denom r1)))
                (mul-poly (denom r1) (denom r2))))

(define (add-rat r1 r2)
  (make-rat (add-poly (mul-poly (numer r1) (denom r2))
                      (mul-poly (numer r2) (denom r1)))
            (mul-poly (denom r1) (denom r2))))

(define t1 (make-poly 'x '((1 1) (0 1))))
(define t2 (make-poly 'x '((3 1) (0 -1))))
(define t3 (make-poly 'x '((1 1))))
(define t4 (make-poly 'x '((2 1) (0 -1))))

(define rf1 (make-rat t1 t2))
(define rf2 (make-rat t3 t4))

(display (add-rat rf1 rf2))
;;unsimplied: '((x (4 -1) (3 -1) (2 -1) (1 2) (0 1)) (x (5 -1) (3 1) (2 1) (0 -1)))
;;simplied: '((x (3 -1) (2 -2) (1 -3) (0 -1)) (x (4 -1) (3 -1) (1 1) (0 1)))