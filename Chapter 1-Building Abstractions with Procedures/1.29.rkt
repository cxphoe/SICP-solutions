(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral-sim f a b n)
  (define h (/ (- b a) n))

  ;determine the cofficient of the elements
  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))

  ;take 'k' as the factor of increment so that the cofficient
  ;of each elements in the recursion procedure can be decided
  (define (term k)
    (* (f (+ a (* k h)))
       (factor k)))

  (define (next k) (+ k 1))
  (if (odd? n)
      "n IS NOT even!"
      (* (/ h 3)
         (sum term 0.0 next n))))

(define (cube x) (* x x x))

(integral-sim cube 0 1 100)
(integral-sim cube 0 1 1000)