(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

;;expand is used to convert a rational number to real number.
;;--num: numer
;;--den: denom
;;--radix: to be 10 usually