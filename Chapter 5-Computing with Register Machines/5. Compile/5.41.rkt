; SICP exercise 5.41
;
; Implement a procedure find-variable, which takes a var and compile-env
; as parameters, and will return a lexical address if var in compile-env
; or symbol 'not-found if not.

; instances:
; (find-variable 'c '((y z) (a b c d e) (x y)))
; (1 2)
; (find-variable 'x '((y z) (a b c d e) (x y)))
; (2 0)
; (find-variable 'w '((y z) (a b c d e) (x y)))
; not-found

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