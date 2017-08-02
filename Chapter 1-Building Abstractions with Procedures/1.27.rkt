(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (fermat-test-all n)
  (define (try-it a)
    (= (expmod a n n) a))
  (define (sub-fermat-test a)
    (if (= a n)
        true
        (if (not (try-it a))
            false
            (sub-fermat-test (+ 1 a)))))
  (sub-fermat-test 2))

;test the six Carmichael numbers given in the books
(fermat-test-all 561)
(fermat-test-all 1105)
(fermat-test-all 1729)
(fermat-test-all 2465)
(fermat-test-all 2821)
(fermat-test-all 6601)