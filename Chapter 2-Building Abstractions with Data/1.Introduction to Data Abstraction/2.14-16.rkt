(load "2.13.rkt")

;;solution for 2.16
;;If one of the two elements(called e1) in the operation have
;;considered the elements (r1 and r2 in this case)that also be
;;taken into account by another one(called e2), then the two
;;elements' values vary in the same rate, which means e1's value
;;is lowest when e2's value is lowest, while e1's value is highest
;;when e2's value is highest.
;;Based on the theory above, I think this problem is about keeping
;;record of the elements' considered elements. If the considered
;;elements of the two elements in the operation are identical then
;;rules of operation need to be changed into "lower-bound against
;;lower-bound, upper-bound against upper-bound", not the opposite.
 
(define (mix-div-interval x y)
  (let ((x-upper (upper-bound x))
        (x-lower (lower-bound x))
        (y-upper (upper-bound y))
        (y-lower (lower-bound y)))
    (make-interval (/ x-lower y-lower)
                   (/ x-upper y-upper))))

(define (par1 r1 r2)
  (mix-div-interval (mul-interval r1 r2)
                    (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define r1 (make-interval 10.2 10.4))
(define r2 (make-interval 5.1 5.3))

(par1 r1 r2)
(par2 r1 r2)