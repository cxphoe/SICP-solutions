; it will end up with an infinite loop when the stream is
; infinite and we won't get any results. The two arguments
; (stream-car stream) and (flatten-stream (stream-cdr stream))
; will be evaluated first, before the interpreter apply
; interleave to them. So the flatten-stream will try to get
; all the elements in the stream, and will never stop until
; the stream is null.

; With a finite stream, it will function well, but it has
; enumerated all the elements in the stream, which means
; the usage of stream will be meaningless.

(define (faltten-stream stream)
  (if (stream-null? stream)
      the-empty-stream
      (interleave
       (stream-car stream)
       (flatten-stream (stream-cdr stream)))))