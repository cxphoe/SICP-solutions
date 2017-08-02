;load prime?
(load "1.28.rkt")

;define GCD
(define (GCD x y)
  (if (= y 0)
      x
      (GCD y (remainder x y))))

(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)
          (combiner (term a)
                    (filtered-accumulate filter combiner null-value term (next a) next b))
          (filtered-accumulate filter combiner null-value term (next a) next b))))

;求出在区间a到b中所有素数之和
(define (primes-sum a b)
  (define (combiner x y) (+ x y))
  (define (term x) x)
  (define (next x)
    (if (odd? x)
        (+ x 2)
        (+ x 1)))
  (cond ((or (< a 0) (< b 0)) "a and b SHOULD BE positive.")
        ((< b a) "b SHOULD NOT BE less than a.")
        (else
         (filtered-accumulate prime? combiner 0 term a next b))))

;小于n的所有与n互素的正整数之乘积
(define (prime-product n)
  (if (< n 2)
      "n SHOULD BE more than 2."
      (filtered-accumulate (lambda (x) (= (GCD x n) 1))
                           (lambda (x y) (* x y))
                           1
                           (lambda (x) x)
                           2
                           (lambda (x) (+ x 1))
                           (- n 1))))