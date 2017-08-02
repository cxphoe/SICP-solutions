(load "derivation.rkt")

(define (addend s) (cadr s))

(define (augend s)
  (if (= 1 (length (cddr s)))
      (caddr s)
      (cons '+ (cddr s))))

(define (multiplier p) (cadr p))

(define (multiplicand p)
  (if (= 1 (length (cddr p)))
      (caddr p)
      (cons '* (cddr p))))
