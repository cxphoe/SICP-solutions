(load "2.95.rkt")

;;a)
(define (pseudoremainder-terms L1 L2)
  (let ((o1 (order (first-term L1)))
        (o2 (order (first-term L2)))
        (c (coeff (first-term L2))))
    (let ((factor (make-term 0 (expt c (- (+ 1 o1) o2)))))
        (pseudo-gcd-terms (mul-terms (list factor) L1)  ;;the version of gcd-terms in this question should've been from 2.95
                          L2))))

(define (pseudo-gcd-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2))
        (t1 (term-list p1))
        (t2 (term-list p2)))
    (if (same-variable? v1 v2)
        (pseudoremainder-terms t1 t2)
        (error "Polys not in same var -- GCD-POLY"
               (list p1 p2)))))

;;b)
(define (pseudo-gcd-terms a b)
  (if (empty-termlist? b)
      (simplify a)
      (pseudo-gcd-terms b (remainder-terms a b))))

(define (simplify term-list)
  (let ((gcd-coeff (apply gcd (map coeff term-list))))
    (car (div-terms term-list
                    (list (make-term 0 gcd-coeff))))))

(define res (pseudo-gcd-poly Q1 Q2))