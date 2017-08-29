(load "pairs.rkt")

(define (pairs s t)
  ;; divide pairs into four parts:
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (interleave
     (stream-map (lambda (x) (list (stream-car s) x))
                 (stream-cdr t))
     (stream-map (lambda (x) (list x (stream-car t)))
                 (stream-cdr s)))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define T2 (pairs integars integars))

(define (T n)
  (display (stream-ref T2 n))
  (newline))

(define (show n)
  (let ((c 0))
    (define (count)
      (if (< c n)
          (begin (T c)
                 (set! c (+ c 1))
                 (count))))
    (count)))

(show 10)