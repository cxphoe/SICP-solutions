(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

; find divisors without testing even numbers if
; (not (= (remainder num 2) 0) which CANNOT halve
; the time to test a prime because of the extra
; procedures
(define (find-divisor n test-divisor)
  (define (next num)
    (if (= num 2)
        3
        (+ num 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

; not to test even numbers CANNOT halve the time
; BUT also won't exceed the former time literally
; because the extra procedures is less than the
; follow procedures
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; search for primes within odd numbers
; with a given number as start
(define (search-for-primes start)
  (define (sub-search num)
    (if (not (prime? num))
        (sub-search (+ num 2))
        (timed-prime-test num)))
  (if (even? start)
      (sub-search (+ start 1))
      (sub-seatch start)))