(define (make-deque) (cons '() '()))
(define (front-ptr d) (car d))
(define (rear-ptr d) (cdr d))

(define (get-item deque endpoint)
  ;get a item from front-ptr or rear-ptr
  (if (empty-deque? deque)
      (error "Can't get item from am empty deque" deque)
      (caar (endpoint deque))))

(define (front-deque deque) (get-item deque front-ptr))
(define (rear-deque deque) (get-itme deque rear-ptr))

(define (empty-deque? deque) (null? (front-ptr deque)))
(define (set-front! deque item) (set-car! deque item))
(define (set-rear! deque item) (set-cdr! deque item))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons (cons item '()) '())))
    ;;there are two empty list in the pair: one for storing the pointer
    ;;pointing to the item behind it, the other one for storing the
    ;;pointer pointing to the item after it.
    (cond ((empty-deque? deque)
           (set-front! deque new-pair)
           (set-rear! deque new-pair))
          (else
           (set-cdr! new-pair (front-ptr deque))
           (set-cdr! (car (front-ptr deque)) new-pair)
           (set-front! deque new-pair)
           (print-deque deque)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons (cons item '()) '())))
    (cond ((empty-deque? deque)
           (set-front! deque new-pair)
           (set-rear! deque new-pair))
          (else
           (set-cdr! (rear-ptr deque) new-pair)
           (set-cdr! (car new-pair) (rear-ptr deque))
           (set-rear! deque new-pair)
           (print-deque deque)))))

(define (front-delete-deque deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else
         (set-front! deque (cdr (front-ptr deque)))
         (if (not (empty-deque? deque))
             (set-cdr! (car (front-ptr deque)) '()))
         (print-deque deque))))

(define (rear-delete-deque deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else
         (set-rear! deque (cdr (car (rear-ptr deque))))
         (if (null? (rear-ptr deque))
             (set-front! deque '())
             (set-cdr! (rear-ptr deque) '()))
         (print-deque deque))))

(define (print-deque deque)
  (display (map car (front-ptr deque)))
  (newline))

(define L (make-deque))
(front-insert-deque! L 'b)
(front-insert-deque! L 'a)
(rear-insert-deque! L 'c)
(rear-insert-deque! L 'd)
(rear-delete-deque L)
(front-delete-deque L)