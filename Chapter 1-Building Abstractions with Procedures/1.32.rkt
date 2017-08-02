(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (next a)
                            next
                            b))))

(define (accumulate-iter combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate-iter combiner
                       (combiner null-value (term a))
                       term
                       (next a)
                       next
                       b)))

(define (sum term a next b)
  (define (combiner x y) (+ x y))
  (accumulate combiner 0 term a next b))

(define (product-iter term a next b)
  (define (combiner x y) (* x y))
  (accumulate combiner 1 term a next b))

(define (integral f a b n)
  (define h (/ (- b a) n))
  
  (define (y k)
    (f (+ a (* k h))))

  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))

  (define (term k)
    (* (factor k)
       (y k)))

  (define (next k) (+ k 1))

  (if (odd? n)
      "n SHOULD BE even!"
      (* (/ h 3)
         (sum term 0.0 next n))))

(define (cube x) (* x x x))

(integral cube 0 1 100)
(integral cube 0 1 1000)

(define (pi-product n)
  (define (term x)
    (/ (* (- x 1) (+ x 1))
       (* x x)))

  (define (next x) (+ x 2))

  (if (< n 3)
      "n SHOULD NOT BE less than 3"
      (* 4
         (product-iter term 3.0 next n))))

(pi-product 1000000)