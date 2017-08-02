(define (square x) (* x x))

(define (square-root x)
  (define (helper guess)
    (if (< (abs (- (square guess) x)) 0.00001)
        guess
        (helper (/ (+ guess (/ x guess))
                   2))))
  (helper 1.0))

(define (prime? x)
  (define (helper a b)
    (cond ((> a b) true)
          ((= (remainder x a) 0) false)
          (else
           (helper (+ a 1) b))))
  (helper 2 (square-root x)))

(define (enumerate-interval m n)
  (if (> m n)
      nil
      (cons m
            (enumerate-interval (+ m 1) n))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (filter proc seq)
  (if (null? seq)
      nil
      (if (proc (car seq))
          (cons (car seq)
                (filter proc (cdr seq)))
          (filter proc (cdr seq)))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 2 n)))))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))