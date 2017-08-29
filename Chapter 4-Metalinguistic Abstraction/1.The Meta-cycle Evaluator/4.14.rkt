; Run the driver-loop, input the defination of map like:
; (define (map proc list)
;   (if (null? list)
;       '()
;       (cons (proc (car list)) (map proc (cdr list)))))

; The input text will be considered as a list.
; The procedure (driver-loop) will call the eval to evaluate the list above.

; Firstly, eval will treat it as definition because the list begins with
; 'define. Then procedure eval-definition will be applied to this list,
; where the selection procedures of definition will separate the list
; into two parts:
;   1st: the function name (like 'map)
;   2nd: the lambda procedure (call the make-lamdba to merge parameters and
;        body of the function.
;        (like '(lambda (proc list)
;                 (if (null? list)
;                     '()
;                     (cons (proc (car list)) (map proc (cdr list)))))
; And the 2nd part will also be evaluated to be:
;   (make-procedure (proc list) (if (null? list) '() ...))
; which will be:
;   '(procedure (proc list) (if (null? list) '() ...) the-global-environment)

; Secondly, procedure define-variable? will be applied to these two parts,
; and the 'map as variable will be bound to '(procedure (proc list) ...)
; as its value in the global-environment.

; Now its definition finishes. If we type in:
; (map (lambda (x) (+ x 2)) '(1 2 3 4))

; Firstly, the procedure will consider it as a application and every elements
; in the list will be evaluated again.
;   (apply (eval 'map env)
;          (list-of-values '((lambda (x) (+ x 3)) '(1 2 3 4))))
; The first one will be seen as operator, and the others as arguments of it.
; In this case, 'map as operator, '(lambda (x) (+ x 3)) and '(quote (1 2 3 4))
; as arguments:
;   'map:                  be evaluated as '(procedure (proc list) (if (null? list) '())...)
;   '(lambda (x) (+ x 3)): be evaluated as '(procedure (x) (+ x 3))
;   '(quote (1 2 3 4)):    be evaluated as '(1 2 3 4)

; Thus, the procedure current woule become as:
;   (apply '(procedure (proc list) (if (null? list) '() ...)
;          '((procedure (x) (+ x 3)) (1 2 3 4)))

; Secondly, the operator will be considered as a compound-procedure, which means
; the procedure apply will try to seperate the parameters and body of the operator,
; create a local environment based on global environment ans bind the parameters
; to the arguments (they have the same amount):
;   (eval-sequence (if (null? list) '() ...)
;                  (extend-environment '(proc list)
;                                      '((procedure (x) (+ x 3)) (1 2 3 4))
;                                      the-global-environment))

; As we know, the function's body is evaluated based on the value of its parameters.
; Now we have a local environment where there are the bindings of the paramenters.
; So the following evaluation can be executed.