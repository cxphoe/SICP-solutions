(define (make-address frame-number offset)
  (list frame-number offset))

(define (addr-frame-number address) (car address))
(define (addr-offset address) (cadr address))

(define (lexical-address-lookup address env)
  (let ((frame (list-ref env (addr-frame-number address))))
    (let ((val (list-ref (frame-values frame)
                         (addr-offset address))))
      (if (eq? val '*unassigned*)
          (error "Undefined variable -- LEXICAL-ADDRESS-LOOKUP")
          val))))
      

(define (lexical-address-set! address env value)
  (let ((frame (list-ref env (addr-frame-number address))))
    (define (iter vals offset)
      (if (= offset 0)
          (set-car! vals value)
          (iter (cdr vals) (- offset 1))))
    (iter (frame-values frame) (addr-offset address))))