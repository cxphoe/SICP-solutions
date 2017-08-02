;;a)
(define (get-record name set)
  (cond ((null? set)
         (error "name not found -- GET-RECORD" name))
        ((eq? name (address (car set)))
         (car set))
        (else
         (get-record name (cdr set)))))
;the record of all affiliated agencies should be a list contains all
;stuff's record with everyone's name as key value

;;c)
(define (find-employee-record name sets)
  (cond ((null? sets)
         (error "record not found -- FIND-EMPLOYEE-RECORD" name))
        ((eq? name (address (car (car sets))))
         (car (car sets)))
        (cons (cdr (car sets))
              (cdr sets))))