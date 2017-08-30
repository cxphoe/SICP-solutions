(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n1 (/ n g)) (d1 (/ d g)))
      (if (< d1 0)
          (cons (- n1) (- d1))
          (cons n1 d1)))))

(define (print-rat x)
  (newline)
  (display (car x))
  (display "/")
  (display (cdr x)))