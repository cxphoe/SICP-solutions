(define (smooth s)
  (stream-map (lambda (x y) (/ (+ x y) 2)) s (stream-cdr s)))

(define (make-zero-crossings input-stream)
  (let ((after-smooth (smooth input-stream)))
    (stream-map sign-change-detetor
                after-smooth
                (stream-cdr after-smooth))))