(load "sequence_operation.rkt")

(define (map p sequence)
  (accumulate (lambda (to-do already-done)
                (cons (p to-do) already-done))
              nil
              sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (to-do already-done)
                (+ 1 already-done))
              0
              sequence))