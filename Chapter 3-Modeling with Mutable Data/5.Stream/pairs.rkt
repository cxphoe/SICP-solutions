(load "3.50.rkt")

(define (interleave s1 s2)
  (if (null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  ;; the pairs is divided into three parts:
  ;; -- the first one pair
  ;; -- pairs containing the first integar of s and integars of t
  ;; -- pairs containing the other integars of s andx other integars of t
  (cons-stream
   (list (stream-car s) (stream-car t))               ;1st part
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))                       ;2nd part
    (pairs (stream-cdr s) (stream-cdr t)))))          ;3rd part

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define ones (cons-stream 1 ones))

(define integars
  (cons-stream 1 (add-streams ones integars)))

(define T (pairs integars integars))

(define (count ps p)
  (define (equ? p1 p2)
    (and (= (car p1) (car p2))
         (= (cadr p1) (cadr p2))))
  (define (iter ps n)
    (if (equ? (stream-car ps) p)
        n
        (iter (stream-cdr ps) (+ n 1))))
  (iter ps 0))

(define (t n)
  (display (stream-ref T (- n 1))))

(define (display-stream s n)
  (if (> n 0)
      (begin (display (stream-car s))
             (newline)
             (display-stream (stream-cdr s) (- n 1)))))