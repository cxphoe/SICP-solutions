(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                     (div-terms
                      (add-terms L1
                                 (mul-term-by-all-terms (make-term 0 -1)
                                                        (mul-term-by-all-terms (make new-o new-c)
                                                                               L2)))
                      L2)))
                (cons (adjoin-term (make-term new-o new-c)
                                   (car rest-of-result))
                      (cdr rest-of-result))))))))