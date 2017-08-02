(load "3.55.rkt")

(define (logarithm-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (logarithm-summands (+ n 1)))))

(define logarithm-stream
  (partial-sums (logarithm-summands 1)))

(define (square x) (* x x))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s1 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define (display-stream s n)
  (if (> n 0)
      (begin (display (stream-car s))
             (newline)
             (display-stream (stream-cdr s) (- n 1)))))

(display-stream (accelerated-sequence euler-transform
                                      logarithm-stream)
                100)