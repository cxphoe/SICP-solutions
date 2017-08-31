; SICP exercise 5.26
;
; inspect the tail recursion by the monitored stack.

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

; test results:
; +-----+--------------+---------------+
; |  n  | total-pushes | maximum-depth |
; +-----+--------------+---------------+
; |  1  |      64      |      10       |
; |  2  |      99      |      10       |
; |  3  |     134      |      10       |
; |  4  |     169      |      10       |
; |  5  |     204      |      10       |
; +-----+--------------+---------------+

; a)
; the maximum-depth stay unchanged because the sequence of if-alternative
; is only one, and the ev-sequence won't save any register. On the other
; hand, the arguments of if-alternative are based on the primitive apply
; which means it's a iteration so it will save specific amount registers
; at a time. The number "10" represent the basic stacked registers in the
; evaluation process.

; b)
; do the math, and get a linear function: 35n + 29.
; which means it will push more 35 times with one more recursion.