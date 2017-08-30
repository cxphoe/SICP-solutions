(define (filter proc seq)
  (if (null? seq)
      '()
      (if (proc (car seq))
          (cons (car seq) (filter proc (cdr seq)))
          (filter proc (cdr seq)))))

(define (flatmap proc seq)
  (if (null? seq)
      '()
      (let ((res (proc (car seq))))
        (if (list? res)
            (append res (flatmap proc (cdr seq)))
            (cons res (flatmap proc (cdr seq)))))))

(define (remove seq elt)
  (filter (lambda (x) (not (eq? x elt))) seq))

(define (multiple-dwelling)
  (define (combination seq)
    (if (null? (cdr seq))
        (list seq)
        (flatmap (lambda (x)
                   (map (lambda (y) (cons x y))
                        (combination (remove seq x))))
                 seq)))

  (define constraint
    (lambda (p1 p2 p3 p4 p5)
      (and (not (= p1 5))
           (not (= p2 1))
           (not (= p3 1))
           (not (= p3 5))
           (not (= (abs (- p3 p2)) 1))
           (> p4 p2)
           (not (= (abs (- p5 p3)) 1)))))
  
  (let ((alternatives (combination '(1 2 3 4 5))))
    (filter (lambda (alter)
              (apply constraint alter))
            alternatives)))
                                     
(define (multiple-dwellings) 
   (define (house-iter b c m f s) 
     (cond ((> b 4) ; Baker can't live on 5th floor. 
            '(no answer available)) 
           ((> c 5)  
            (house-iter (+ b 1) 2 3 2 1)) 
           ((> m 5) 
            (house-iter b (+ c 1) (+ c 2) 2 1)) ; miller is above cooper 
           ((> f 4) ; fletcher can't live on 5th floor 
            (house-iter b c (+ m 1) 2 1)) 
           ((> s 5) 
            (house-iter b c m (+ f 1) 1)) 
           ((and (not (= (abs (- s f)) 1)) 
                 (not (= (abs (- c f)) 1)) 
                 (distinct? (list b c m f s))) 
            (list (list 'baker b) (list 'cooper c) 
                  (list 'fletcher f) (list 'miller m) 
                  (list 'smith s))) 
           (else  
             (house-iter b c m f (+ s 1))))) 
     (house-iter 1 2 3 2 1)) ; initial values take some restrictions into account 

(define (distinct? seq)
  (cond ((null? seq) true)
        ((null? (cdr seq)) true)
        ((member (car seq) (cdr seq)) false)
        (else (distinct? (cdr seq)))))

(display (multiple-dwelling))
(display (multiple-dwellings))