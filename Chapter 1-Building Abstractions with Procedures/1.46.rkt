(define (iterative-improve close-enough? improve)
  (lambda (first-guess)
    (define (try guess)
      (let ((next (improve guess)))
        (if (close-enough? guess next)
            next
            (try next))))
    (try first-guess)))

(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) 0.0001))

(define (sqrt x)
  ((iterative-improve close-enough?
                      (lambda (guess) (/ (+ guess (/ x guess)) 2)))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve close-enough? f)
   1.0))

