...
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
...

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