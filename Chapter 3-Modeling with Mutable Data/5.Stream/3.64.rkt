(load "stream.rkt")

(define (stream-limit s tolerance)
  ;;the guess in the stream guesses is already memoized
  (if (> tolerance
         (abs (- (stream-ref s 1) (stream-ref s 0))))
      (stream-ref s 1)
      (stream-limit (stream-cdr s) tolerance)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (sqrt-improve guess x)
  (/ (+ (/ x guess)
        guess)
     2))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(sqrt 10 0.0001)