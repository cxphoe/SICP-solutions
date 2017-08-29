(load "pairs.rkt")

(define (triples S T U)
  (let ((ps (pairs T U)))
    (cons-stream
     (cons (stream-car S) (stream-car ps))
     (interleave
      (stream-map (lambda (p) (cons (stream-car S) p))
                  (stream-cdr ps))
      (triples (stream-cdr S) (stream-cdr T) (stream-cdr U))))))

(define (square-sum-equal? tris)
  (define (square x) (* x x))
  (= (+ (square (car tris)) (square (cadr tris)))
     (square (caddr tris))))

(define pyth (stream-filter square-sum-equal?
                            (triples integars integars integars)))

(define (p n)
  (display (stream-ref pyth (- n 1))))