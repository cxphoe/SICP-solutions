(define (conjoin conjucts frame-stream)
  (if (empty-conjuction? (cdr rest-conjuncts))
      (qeval (first-conjuct conjucts) frame-stream)
      (merge (qeval (first-conjunct conjucts) frame-stream)
             (conjoin (rest-conjuncts conjuncts)
                      frame-stream))))

(define (merge frame-stream-1 frame-stream-2)
  (flatten-stream
   (stream-map (lambda (frame-1 frame-2)
                 (merge-match frame-1 frame-2))
               frame-stream-1
               frame-stream-2)))

(define (check-bindngs frame-1 frame-2)
  (let ((match-result
         (merge-match frame-1 frame-2 '())))
    (if (eq? match-result 'failed)
        the-empty-stream
        (singleton-stream match-result))))

(define (merge-match frame-1 frame-2 res)
  (if (stream-null? frame-1)
      (append res frame-2)
      (let ((first (car frame-1)))
        (let ((match (binding-in-frame (binding-variable first))))
          (if match
              (if (eq? (bind-final-value first frame-1)
                       (bind-final-value match frame-2))
                  (merge-match (cdr frame-1) frame-2 res)
                  'failed)
              (merge-match (cdr frame-1) frame-2 (cons first res)))))))