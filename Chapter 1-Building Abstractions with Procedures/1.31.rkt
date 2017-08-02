(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

;factorial
(define (factorial n)
  (define (identity x) x)
  (define (inc n) (+ n 1))
  (if (= n 0)
      0
      (product-iter identity 1 inc n)))

(define (pi-sum n)
  (define (next n) (+ n 2))

  (define (term n)
    (/ (* (- n 1) (+ n 1))
       (* n n)))

  (* 4
     (product term 3.0 next n)))

(pi-sum 1000000)