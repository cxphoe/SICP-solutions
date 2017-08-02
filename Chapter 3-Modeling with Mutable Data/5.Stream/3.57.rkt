(load "3.50.rkt")

(define count 0)

(define (add-streams s1 s2)
  (stream-map (lambda (x y) (begin (set! count (+ count 1))
                                   (+ x y)))
              s1 s2))

(define fibs (cons-stream 0
                          (cons-stream 1
                                       (add-streams (stream-cdr fibs)
                                                    fibs))))
(define (display-stream s n)
  (if (> n 0)
      (begin (display (stream-car s))
             (newline)
             (display-stream (stream-cdr s) (- n 1)))))

(stream-ref fibs 10)
(display "the running time of add: ")
(display count)