;; a)
((lambda (n)
   ((lambda (fib)        ; use a lambda'a parameter to keep the recursion
                         ; function
      (fib fib n))       ; the first element functions as a procedure,
                         ; the rest of two as its arguments.
                         ; the second 'fib' is for transmitting the
                         ; procedure itself for the next recursion. 
    (lambda (f k)
      (cond ((= k 0) 0)
            ((= k 1) 1)
            (else
             (+ (f f (- k 1)) (f f (- k 2))))))))
 10)

;; b)
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0)
         true
         (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0)
         false
         (ev? ev? od? (- n 1))))))