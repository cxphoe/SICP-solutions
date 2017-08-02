(load "1.41.rkt")
(load "1.42.rkt")

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

;recursion (O(log(n)))
(define (repeated-recur f n)
  (cond ((= n 1) f)
        ((even? n)
         (double (repeated-recur f (/ n 2))))
        (else
         (compose f (repeated-recur f (- n 1))))))

;iteration (O(log(n)))
(define (repeated-iter f n)
  (define (helper g k)
    (cond ((= k 1) g)
          ((even? k)
           (helper (double g) (/ k 2)))
          (else
           (helper (compose k g) (- k 1)))))
  (helper f n))

;((repeated (lambda (x) (* x x)) 2) 5)
;((repeated-recur (lambda (x) (* x x)) 2) 5)
;((repeated-iter (lambda (x) (* x x)) 2) 5)