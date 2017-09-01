;(load "expression.rkt")

; check the primitives
;; there are two things have to check for a primitive:
;; -- 1st: arity
;; -- 2nd: contract

;; for checking the arity
(define (arity-check args least expect pname)
  ;   args: passed in arguments of apply
  ;  least: lower limit of arity
  ; expect: expected arity
  ;  pname: the name string of primitives
  (let ((arity (length args)))
    (cond ((and least (< arity least))
           (make-error (arity-error pname least arity #t)))
          ((and expect (not (= arity expect)))
           (make-error (arity-error pname expect arity #f)))
          (else #f))))

(define (arity-error pname expect given least-mode)
  (string-append pname
                 ": arity mismatch;\n  "
                 (if least-mode
                     "expected: at least "
                     "expected: ")
                 (number->string expect)
                 "\n  given: "
                 (number->string given)))

;; for checking the contract
(define (contract-check args op pname cname)
  ;    op: for check contract
  ; pname: name string of primitives
  ; cname: name string of op
  (if (null? args)
      #f
      (let ((first (car args)))
        (if (op first)
            (contract-check (cdr args) op pname cname)
            (make-error (contract-error pname cname) first)))))

(define (contract-error pname cname)
  (string-append pname
                 ": contract violation\n"
                 "  expected: "
                 cname
                 "\n  given:"))

;; for pair operations
(define (ccar . args)
  (or (arity-check args #f 1 "car")
      (contract-check args pair? "car" "pair?")
      (apply car args)))
        
(define (ccdr . args)
  (or (arity-check args #f 1 "cdr")
      (contract-check args pair? "cdr" "pair?")
      (apply cdr args)))

(define (ccons . args)
  (or (arity-check args #f 2 "cons")
      (apply cons args)))

(define (cnull? . args)
  (or (arity-check args #f 1 "null?")
      (apply null? args)))

;; for arithmatic signs
(define (c+ . args)
  (or (contract-check args number? "+" "number?")
      (apply + args)))

(define (c* . args)
  (or (contract-check args number? "*" "number?")
      (apply * args)))

(define (c- . args)
  (or (arity-check args 1 #f "-")
      (contract-check args number? "-" "number?")
      (apply - args)))

;; special case: division
(define (c/ . args)
  (or (arity-check args 1 #f "/")
      (contract-check args number? "/" "number?")
      (zero-check (cdr args))
      (apply / args)))

(define (zero-check args)
  (if (member 0 args)
      (make-error "/: division by zero")
      #f))

;; for comparison sign
(define (comparison-apply op args pname)
  (or (arity-check args 2 #f pname)
      (contract-check args number? pname "number?")
      (apply op args)))

(define (c= . args)
  (comparison-apply = args "="))

(define (c> . args)
  (comparison-apply > args ">"))

(define (c< . args)
  (comparison-apply < args "<"))

(define (c>= . args)
  (comparison-apply >= args ">="))

(define (c<= . args)
  (comparison-apply <= args "<="))

(define (ceq? . args)
  (or (arity-check args #f 2 pname)
      (apply op args)))