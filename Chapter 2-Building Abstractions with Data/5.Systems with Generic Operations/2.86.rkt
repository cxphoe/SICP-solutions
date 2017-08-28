(define (sine x) (apply-generic 'sine x)) 
(define (cosine x) (apply-generic 'cosine x)) 
  
;; add into scheme-number package 
(put 'sine 'scheme-number
     (lambda (x) (tag (sin x))))
(put 'cosine 'scheme-number
     (lambda (x) (tag (cos x))))

;; add into rational package 
(put 'sine 'rational 
     (lambda (x) (tag (sin (/ (numer x) (denom x))))))
(put 'cosine 'rational 
     (lambda (x) (tag (cos (/ (numer x) (denom x))))))

;; To accomodate generic number in the complex package,  
;; we should replace operators such as + , * with theirs 
;; generic counterparts add, mul. 
(define (add-complex z1 z2) 
  (make-from-real-imag (add (real-part z1) (real-part z2)) 
                       (add (imag-part z1) (imag-part z2)))) 
(define (sub-complex z1 z2) 
  (make-from-real-imag (sub (real-part z1) (real-part z2)) 
                       (sub (imag-part z1) (imag-part z2)))) 
(define (mul-complex z1 z2) 
  (make-from-mag-ang (mul (magnitude z1) (magnitude z2)) 
                     (add (angle z1) (angle z2)))) 
(define (div-complex z1 z2) 
  (make-from-mag-ang (div (magnitude z1) (magnitude z2)) 
                     (sub (angle z1) (angle z2)))) 