;; constructor
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; selector
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;======================================;

(define (branch-weight branch)
  (let ((stru (branch-structure branch)))
    (if (pair? stru)
        (total-weight stru)
        stru)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branch-balanced? branch)
  (let ((stru (branch-structure branch)))
    (if (pair? stru)
        (balanced? stru)
        true)))

(define (branch-torque branch)
  (* (branch-weight branch)
     (branch-length branch)))

(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (= (branch-torque left)
            (branch-torque right))
         (branch-balanced? left)
         (branch-balanced? right))))

(define level-1-mobile (make-mobile (make-branch 2 1) 
                                     (make-branch 1 2))) 
(define level-2-mobile (make-mobile (make-branch 3 level-1-mobile) 
                                     (make-branch 9 1))) 
(define level-3-mobile (make-mobile (make-branch 4 level-2-mobile) 
                                     (make-branch 8 2))) 
  
(total-weight level-1-mobile) 
(total-weight level-2-mobile) 
(total-weight level-3-mobile)

(balanced? level-1-mobile) 
(balanced? level-2-mobile) 
(balanced? level-3-mobile) 
  
(balanced? (make-mobile (make-branch 10 1000) 
                         (make-branch 1 level-3-mobile))) 