(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unkonwn expression type -- DERIV" exp))))

(define (precedence op)
  (cond ((eq? op '-) 1)
        ((eq? op '+) 1)
        ((eq? op '*) 2)
        ((eq? op '^) 3)
        (else (error "unknown operator -- PRECEDENCE" op))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2) 
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? expr)
  (eq? '+ (smallest-op expr)))

(define (addend expr)
  (let ((res (prefix '+ expr)))
    (if (single? res)
        (car res)
        res)))

(define (augend expr)
  (let ((res (postfix '+ expr)))
    (if (single? res)
        (car res)
        res)))

(define (product? expr)
  (eq? '* (smallest-op expr)))

(define (multiplier expr)
  (let ((res (prefix '* expr)))
    (if (single? res)
        (car res)
        res)))

(define (multiplicand expr)
  (let ((res (postfix '* expr)))
    (if (single? res)
        (car res)
        res)))

(define (smallest-op expr)
  (define (iter min-op expr)
    (if (null? expr)
        min-op
        (iter (if (< (precedence (car expr))
                     (precedence min-op))
                  (car expr)
                  min-op)
              (cddr expr))))
  (iter (cadr expr) (cdddr expr)))

(define (prefix op expr)
  (if (or (null? expr) (eq? op (car expr)))
      '()
      (cons (car expr) (prefix op (cdr expr)))))

(define (postfix op expr)
  (cdr (memq op expr)))

(define (single? l) (= 1 (length l)))

(define t1 '(x + 3 * (x + y + 2)))
(define t2 '(3 * x * x + 4 * x * (y + 4) + (y + 2)))

(display (deriv t1 'x))
(newline)
(display (deriv t2 'x))