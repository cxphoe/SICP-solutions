;; a)
;;letrec: (letrec ((<var1> <exp1>) ... (<varn> <expn>))
;;          <body>)
(define (letrec? exp)
  (tagged-list? exp 'letrec))

(define (letrec-bindings exp) (cadr exp))
(define (letrec-body exp) (cddr exp))

(define (declare-vars exp)
  (map (lambda (bind)
         (list (car bind) ''unassigned))
       (letrec-bindings exp)))
(define (set-vals exp)
  (map (lambda (bind)
         (make-assignment (car bind) (cadr bind)))
       (letrec-bindings exp)))

(define (letrec->let exp)
  (make-let (declare-vars exp)
            (append (set-vals exp)
                    (letrec-body exp))))

;; b)
;; The lambda in `let' is evaluated in the context of the enclosing environment, 
;; in which the bindings of the lambda itself are not in place.
  
;; The trick of encoding `letrec' is that we first establish the bindings, and 
;; then define the lambdas in an environment where the bindings are there, so 
;; the recursive call can succeed. 
  
;; The following snippets illustrate the difference: 
  
(let ((fact <fact-body>)) 
  <let-body>) 
  
;; is encoded by 
  
((lambda (fact) 
   <let-body>) 
 <fact-body>) 
  
;; such that `<fact-body>' can't refer to `fact'. While: 
  
(letrec ((fact <fact-body>)) 
  <let-body>) 
  
;; is encoded by 
  
((lambda (fact) 
   (set! fact <fact-body>) 
   <fact-body>)
 '*unassigned*) 
  
;; note that in the context of `<fact-body>', the variable `fact' itself is 
;; bound.