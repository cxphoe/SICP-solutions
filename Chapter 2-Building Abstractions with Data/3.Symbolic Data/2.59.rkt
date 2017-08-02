(define (union-set set1 set2)
  (define (iter res set)
    (if (null? set)
        res
        (iter (if (element-of-set? (car set) set1)
                  res
                  (cons (car set) res))
              (cdr set))))
  (iter set1 set2))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))