(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (monte-carlo trials (P x1 x2 y1 y2))
     (* (- x2 x1) (- y2 y1))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low
       (* (/ (random 100) 100.0) range))))
;;change (random range) into (* (/ (random 100) 100.0) range) in order
;;to get a float instead of a integar to increse the accuracy.

(define (square x) (* x x))
(define (average a b) (/ (+ a b) 2))

(define (P x1 x2 y1 y2)
  (let ((radius (/ (- x2 x1) 2))
        (x-coordinate (average x1 x2))
        (y-coordinate (average y1 y2)))
    (lambda ()
      (<= (+ (square (- (random-in-range x1 x2)
                        x-coordinate))
             (square (- (random-in-range y1 y2)
                        y-coordinate)))
          (square radius)))))

(/ (estimate-integral P 2 8 4 10 10000)
      9.0)
(/ (estimate-integral P 2 8 4 10 10000)
      9.0)
(/ (estimate-integral P 2 8 4 10 10000)
      9.0)