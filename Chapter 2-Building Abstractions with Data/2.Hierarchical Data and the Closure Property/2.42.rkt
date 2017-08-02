(load "nested_mapping.rkt")

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board nil)

(define (adjoin-position new-row column rest-of-queens)
  ; create a sequence including the positions represented
  ; by column and row and ranked by the column
  (append rest-of-queens
          (list (cons column new-row))))

(define (safe-row p1 p2)
  (not (= (cdr p1) (cdr p2))))

(define (safe-diag p1 p2)
  (not (= (abs (- (car p1) (car p2)))
          (abs (- (cdr p1) (cdr p2))))))

(define (safe? column positions)
  ; get the test object for further testing
  (define test-obj (list-ref positions (- column 1)))

  ; test from the first one position to the test object itself
  (define (helper rest)
    (let ((first (car rest)))
      (cond ((= (car first) column) true)
            ; the column of each position is unique and increase by one
            ; from left to right. So if the column of first position of
            ; rest is identical to test-obj's, it means the (k-1) columns
            ; before test-obj have passed the test, which also mean the
            ; safe? test is passed.
            ((or (not (safe-row test-obj first))
                 (not (safe-diag test-obj first)))
             false)
            ; test the rest of positions
            (else (helper (cdr rest))))))
  (helper positions))

(define (display-queen q)
  (if (null? q)
      0
      ((display (car q))
       (newline)
       (display-queen (cdr q)))))

(display-queen (queens 8))