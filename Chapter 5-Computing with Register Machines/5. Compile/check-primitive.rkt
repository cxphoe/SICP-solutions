; for car and cdr
(define (car-check obj)
  (if (pair? obj)
      (cons 'pair (car obj))
      (cons 'not-pair '())))

(define (cdr-check obj)
  (if (pair? obj)
      (cons 'pair (car obj))
      (cons 'not-pair '())))

(define (not-pair? obj)
  (tagged-list? obj 'not-pair))

(define (cons-check . args)
  (if (= 2 (length args))
      (cons 'done (apply cons args))
      (if (< 2 (length args))
          (cons 'too-many-arguments '())
          (cons 'too-few-arguments '()))))

(define (too-many-arguments? obj)
  (tagged-list? obj 'too-many-arguments))

(define (too-few-arguments? obj)
  (tagged-list? obj 'too-few-arguments))

(define (list-check . args)
  (cons 'done (apply list args)))

(define (null?-check . args)
  (if (not (= 1 (length args)))
      (cons 'number-of-args-not-match '())
      (cons 'done (apply null? args))))

(define (number-of-args-not-match? obj)
  (tagged-list? obj 'number-of-args-not-match))

; for arithmatic signs
(define (arg-is-not-number? obj)
  (tagged-list? obj 'not-number))

(define (at-least-one-arg? obj)
  (tagged-list? obj 'at-least-one-arg))

(define (at-least-two-args? obj)
  (tagged-list? obj 'at-least-two-args))

(define (division-by-zero? obj)
  (tagged-list? obj 'division-by-zero))

(define (filter proc seq)
  (cond ((null? seq) '())
        ((proc (car seq))
         (cons (car seq) (filter proc (cdr seq))))
        (else
         (filter proc (cdr seq)))))

(define (arithmatic-check proc args)
  (let ((test (filter (lambda (arg)
                        (not (real? arg)))
                      args)))
    (if (null? test)
        (cons 'done (apply proc args))
        (cons 'not-number '()))))

(define (plus-check . args)
  (arithmatic-check + args))

(define (mul-check . args)
  (arithmatic-check * args))

(define (minus-check . args)
  (if (null? args)
      (cons 'at-least-one-arg '())
      (arithmatic-check - args)))

(define (div-check . args)
  (if (null? args)
      (cons 'at-least-one-arg '())
      (let ((test (filter (lambda (arg)
                            (eq? arg 0))
                          (cdr args))))
        (if (null? test)
            (arithmatic-check / args)
            (cons 'division-by-zero '())))))

(define (compare-check proc args)
  (if (> 2 (length args))
      (cons 'at-least-two-args '())
      (arithmatic-check proc args)))

(define (equal-check . args)
  (compare-check = args))

(define (greater-than-check . args)
  (compare-check > args))

(define (less-than-check . args)
  (compare-check < args))

(define (<=check . args)
  (compare-check = args))
  
(define (>=check . args)
  (compare-check = args))