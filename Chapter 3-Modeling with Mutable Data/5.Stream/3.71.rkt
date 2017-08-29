(load "3.70.rkt")

(define (triple x) (* x x x))

(define (remanujan-weight p)
  (+ (triple (car p))
     (triple (cadr p))))

(define remanujan-weighted-pairs
  (weighted-pairs integars integars remanujan-weight))

(define (find-remanujan-numbers s)
  (let ((c1 (stream-car s))
        (c2 (stream-car (stream-cdr s))))
    (if (= (remanujan-weight c1)
           (remanujan-weight c2))
        (cons-stream (remanujan-weight c1)
                     (find-remanujan-numbers (stream-cdr (stream-cdr s))))
        (find-remanujan-numbers (stream-cdr s)))))

(define remanujan-stream
  (find-remanujan-numbers remanujan-weighted-pairs))


;;another solution
(define cube-stream remanujan-weighted-pairs)
(define cube-weight remanujan-weight)

(define ram-stream 
  (stream-map cadr  
              (stream-filter (lambda (x)
                               (= (cube-weight (car x))(cadr x)))  
                             (stream-map list
                                         cube-stream
                                         (stream-cdr (stream-map
                                                      cube-weight
                                                      cube-stream))))))