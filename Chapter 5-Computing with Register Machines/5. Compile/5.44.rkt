; SICP exercise 5.43
;
; To ensure the new bindings of open code operators would work as expected.

(define (rebound? op compile-env)
  (not (eq? (find-variable op compile-env)
            'not-found)))

; change the open-code?
(define (open-code? exp compile-env)
  (and (pair? exp)
       (memq (car exp) open-operators)
       (not (rebound? (car exp) compile-env))))