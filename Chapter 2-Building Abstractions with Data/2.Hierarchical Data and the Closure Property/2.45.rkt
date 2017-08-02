(define (split part-combine subpart-combine)
  ((lambda (painter n)
     (if (< n 0)
         painter
         (let ((smaller ((split part-combine subpart-combine) painter (- n 1))))
           (part-combine painter (subpart-combine painter painter)))))))