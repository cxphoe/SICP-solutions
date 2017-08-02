(define (last-pair items)
  (if (null? (cdr items))
      items
      (last-pair (cdr items))))