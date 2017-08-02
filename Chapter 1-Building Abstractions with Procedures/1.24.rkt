(define (square x) (* x x))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                       m))
          (else (remainder (* base (expmod base (- exp 1) m))
                           m))))

(define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))

(define (prime? n)
    (fast-prime? n 100))

(define (start-prime-test n start-time)
  (if (prime? n)
      (show-detail n (- (runtime) start-time))
      false))

(define (show-detail n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (recording-test-time n)
  (start-prime-test n (runtime)))

(define (search-for-primes n count)
  (if (> count 0)
      (if (recording-test-time n) (search-for-primes (+ n 1) (- count 1))
          (search-for-primes (+ n 1) count))))

(define (find-prime start)
  (search-for-primes start 3))