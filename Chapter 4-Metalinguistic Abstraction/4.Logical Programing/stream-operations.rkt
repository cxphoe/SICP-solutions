;; basic procedure of stream
(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-null? s) (null? s))

(define the-empty-stream '())

(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (stream-append (stream-cdr s1) s2))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
  
(define (display-stream s)
  (if (not (stream-null? s))
      (begin (newline)
             (display (stream-car s))
             (display-stream (stream-cdr s)))))

;; stream operations for query
(define (stream-append-delayed s1 delayed-s2)
  (if (stream-null? s1)
      (force delayed-s2)
      (cons-stream
       (stream-car s1)
       (stream-append-delayed (stream-cdr s1) delayed-s2))))

;; use singleton-stream to force a elment become a stream
;; so that it's able to interleave. the procedure follow
;; can filter the empty lists and merge the lists.
(define (interleave-delayed s1 delayed-s2)
  (if (stream-null? s1)
      (force delayed-s2)
      (cons-stream
       (stream-car s1)
       (interleave-delayed (force delayed-s2)
                           (delay (stream-cdr s1))))))

(define (stream-flatmap proc s)
  ;; (stream-car s) is also a stream created by singletion-stream
  (flatten-stream (stream-map proc s)))

(define (flatten-stream stream)
  (if (stream-null? stream)
      the-empty-stream
      (interleave-delayed
       (stream-car stream)
       (delay (flatten-stream (stream-cdr stream))))))

(define (singleton-stream x)
  (cons-stream x the-empty-stream))