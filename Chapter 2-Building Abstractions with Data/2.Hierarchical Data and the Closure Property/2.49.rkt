(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segment->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (frame-segments frame)
  ; frame: origin, edge1, edge2
  (let ((origin (origin-frame frame))
        (edge1 (edge1-frame frame))
        (edge2 (edge2-frame frame)))
    (let ((left-point (add-vect origin edge1))
          (right-point (add-vect origin edge2))
          (top-point (add-vevt origin (add-vect edge1 edge2))))
      (list (make-segment origin left-point)
            (make-segment left-point top-point)
            (meke-segment top-point right-point)
            (make-segment right-point origin)))))

(define (painter-1 frame)
  ((segment->painter (frame-segments frame)) frame))

(define (frame-diag-segments frame)
  (let ((origin (origin-frame frame))
        (edge1 (edge1-frame frame))
        (edge2 (edge2-frame frame)))
    (let ((left-point (add-vect origin edge1))
          (right-point (add-vect origin edge2))
          (top-point (add-vevt origin (add-vect edge1 edge2))))
      (list (make-segment origin top-point)
            (make-segment left-point right-point)))))

(define (painter-2 frame)
  ((segment->painter (frame-diag-segments frame)) frame))