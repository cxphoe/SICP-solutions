(define (make-address frame-number offset)
  (list frame-number offset))

(define (addr-frame-number address) (car address))
(define (addr-offset address) (cadr address))

(define empty-compile-environment '())

(define (extend-compile-env parameters compile-env)
  (cons parameters compile-env))

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

(define (lexical-address-lookup address env)
  (let ((frame (list-ref env (addr-frame-number address))))
    (let ((val (list-ref (frame-values frame)
                         (addr-offset address))))
      (if (eq? val '*unassigned*)
          (error "Undefined variable -- LEXICAL-ADDRESS-LOOKUP")
          val))))      

(define (lexical-address-set! address value env)
  (let ((frame (list-ref env (addr-frame-number address))))
    (define (iter vals offset)
      (if (= offset 0)
          (set-car! vals value)
          (iter (cdr vals) (- offset 1))))
    (iter (frame-values frame) (addr-offset address))))

