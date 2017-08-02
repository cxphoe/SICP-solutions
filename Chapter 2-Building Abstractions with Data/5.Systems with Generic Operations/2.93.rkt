(define (make-rat n d)
  (define (gcd-terms a b)
    (if (empty-termlist? b)
        a
        (gcd-terms b (remainder-terms a b))))
  (define (remainder-terms a b)
    (cadr (div-terms a b)))

  (let ((v1 (variable n))
        (v2 (variable d))
        (t1 (term-list n))
        (t2 (term-list d)))
    (if (same-variable? v1 v2)
        (let ((g (gcd-terms t1 t2)))
          (cons (car (div-terms t1 g))
                (car (div-terms t2 g))))
        (error "Polys not in same var -- MAKE-RAT"
               (list n d)))))