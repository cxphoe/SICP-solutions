(load "mutex.rkt")

(define (make-serial-number)
  (let ((serial-number 10000))
    (define (make-account balance)
      (let ((id serial-number))
        (set! serial-number (+ serial-number 1))
        (define (withdraw amount)
          (if (>= balance amount)
              (begin (set! balance (- balance amount))
                     balance)
              "Incufficient funds"))
        (define (deposit amount)
          (set! balance (+ balance amount))
          balance)
        (let ((balance-serializer (make-serializer)))
          (define (dispatch m)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  ((eq? m 'balance) balance)
                  ((eq? m 'serializer) balance-serializer)
                  ((eq? m 'id) id)
                  (else (error "Unknown request -- MAKE-ACCOUNT" m))))
          dispatch)))
      make-account))

;;exchange
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((id1 (account1 'id))
        (id2 (account2 'id))
        (serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    (if (< id1 id2)
        ((serializer1 (serializer2 exchange))
         account1
         account2)
        ((serializer2 (serializer1 exchange))
         account1
         account2))))

;;test
(define make-account (make-serial-number))

(define account1 (make-account 100))
(define account2 (make-account 50))

(serialized-exchange account1 account2)
(serialized-exchange account2 account1)