(define (delay value)
  (let ((previous value))
    (lambda (x)
      (begin (set! previous value)
             (set! value (+ value x))
             previous))))

(define f1 (delay 0))
(define f2 (delay 0))

(+ (f1 0) (f1 1))
(+ (f2 1) (f2 0))