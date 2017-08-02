(load "2.2.rkt")

;take in two segment as length and width of rectangle
(define (make-rectangle length-seg width-seg)
  (cons length-seg width-seg))

(define (length-seg-of-rec r)
  (car r))

(define (width-seg-of-rec r)
  (cdr r))

(define (length-of-rec r)
  (let ((length-seg (length-seg-of-rec r)))
    (let ((start (start-segment length-seg))
          (end (end-segment length-seg)))
      (- (x-point end)
         (x-point start)))))

(define (width-of-rec r)
  (let ((width-seg (width-seg-of-rec r)))
    (let ((start (start-segment width-seg))
          (end (end-segment width-seg)))
      (- (y-point end)
         (y-point start)))))

(define (perimeter-rectangle r)
  (let ((length (length-of-rec r))
        (width (width-of-rec r)))
    (* 2
       (+ length width))))

(define (area-rectangle r)
  (let ((length (length-of-rec r))
        (width (width-of-rec r)))
    (* length width)))