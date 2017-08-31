; SICP exercise 5.29
;
; inspect the stack operations of tree recursion like: fib

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

; test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      16      |       8       |
; |  2  |      72      |      13       |
; |  3  |     128      |      18       |
; |  4  |     240      |      23       |
; |  5  |     408      |      28       |
; +-----+--------------+---------------+

; a)
; linear function of maximum-depth: 5n + 3
; there is no difference between tree recursion and linear recursion.
; because the depth is basically depended on the (fib (- n 1)), when
; it finished, the space it occupied will be released. and obviously
; (fib (- n 2)) won't need as mush space as (fib (- n 1)).

; b)
; math :-)
; S(n) = 2 * S(n-1) - S(n-2) + 56 (n>=4)
; S(n) = 56 * Fib(n+1) - 40 (n>=1)