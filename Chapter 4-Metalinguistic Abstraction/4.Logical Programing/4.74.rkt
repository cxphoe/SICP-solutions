;; a)
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-faltten stream)
  (stream-map stream-car
              (stream-filter (lambda (frame) (not (stream-null? frame)))
                             stream)))

;; b)
;; the procedure inside stream-operations will function the same as before
;; if we have change it into the above code.