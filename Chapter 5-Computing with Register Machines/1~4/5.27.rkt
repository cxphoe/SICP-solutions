; SICP exercise 5.27
;
; compare the recursive factorial with iterative one from 5.26.

(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

; test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      16      |       8       |
; |  2  |      48      |      13       |
; |  3  |      80      |      18       |
; |  4  |     112      |      23       |
; |  5  |     144      |      28       |
; +-----+--------------+---------------+

; do the math again, and get a linear function about the maximum-depth:
; 5n + 3. The n gets bigger, the maximum-depth gains more;
; another linear function is about total-pushes: 32n - 16

; +-----------+---------------+--------------+
; |           | maximum-depth | total-pushes |
; +-----------+---------------+--------------+
; | recursion |    5n + 3     |   32n - 16   |
; | iteration |      10       |   35n + 29   |
; +-----------+---------------+--------------+

; The total-pushes represents the total runtime, and the maximum-depth
; represents the space that the process will occupy.