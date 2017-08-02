(define (find-variable var compile-env)
  (define (search-frame frame-ref env)
    (if (null? env)
        'not-found
        (let ((offset (search-var 0 (car env))))
          (if offset
              (make-address frame-ref offset)
              (search-frame (+ 1 frame-ref) (cdr env))))))
  (define (search-var offset frame)
    (cond ((null? frame) false)
          ((eq? var (car frame)) offset)
          (else
           (search-var (+ offset 1) (cdr frame)))))
  (search-frame 0 compile-env))

(define (make-address frame-number offset)
  (list frame-number offset))