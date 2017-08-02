(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (no-more? coin-value)
  (null? coin-value))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (first-denomination coin-values)
  (car coin-values))

(cc 100 us-coins)
(cc 100 uk-coins)

;;the sequence of the coin-values would not affect the final
;;result of procedure cc because the process of cc is about
;;combination which will consider all the possibility of
;;comnination like in us-coins the result will be the same
;;no matter 50 is in the first one or else.