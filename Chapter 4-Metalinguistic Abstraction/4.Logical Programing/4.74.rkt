;; a)
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-faltten stream)
  (stream-map stream-car
              (stream-filter (lambda (frame) (not (stream-null? frame)))
                             stream)))

;; b)
;; the procedure inside stream-operations will function the same as before
;; even if we have change it into the above code. Because there are just
;; some empty streams and streams with only one eltment in the stream.