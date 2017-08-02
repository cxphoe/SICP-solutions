(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))

(define (make-rat n d)
  (if (< d 0)
      (cons (- n) (- d))
      (cond n d)))

  (let ((g (gcd (abs n) (abs d))))
    (pos-or-neg? (/ n g) (/ d g))))

(define (print-rat x)
  (newline)
  (display (car x))
  (display "/")
  (display (cdr x)))