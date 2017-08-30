; Without implementation, just clear the thoughts

; Due to the existence of abstract barriers (use seletors in simulation),
; changing the forms below will not affect the excecution only if what we
; input conform to the syntactic forms.


;; take the follows as instance. We can change it into whatever we want it
;; to be.

;; ((op proc) (reg ...) (const ...) ...)
;; could be changed into ((reg ...) (op proc) (const ...) ...)
(define (operation-exp? exp)
  (and (pair? exp) (tagged-list? (car exp) 'op)))

(define (operation-exp-op operation-exp)
  (cadr (car operation-exp)))

(define (operation-exp-operands operation-exp)
  (cdr operation-exp))