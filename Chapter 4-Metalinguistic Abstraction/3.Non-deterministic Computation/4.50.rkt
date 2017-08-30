;; version 1
(define (analyze-ramb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            (let ((l (length choices)))
              (let ((c (list-ref choices (random l))))
                (c env
                   succeed
                   (lambda ()
                     (try-next (remove choices c))))))))
      (try-next cprocs))))

(define (remove seq elt)
  (filter (lambda (x) (not (eq? elt x))) seq))

;; version 2: won't do extra works during running
(define (shuffle seq)
  (define (iter seq res)
    (if (null? seq)
        res
        (let ((index (random (length seq))))
          (let ((element (list-ref seq index)))
            (iter (remove seq element)
                  (cons element res))))))
  (iter seq nil))

(define (ramb-choices exp) (shuffle (cdr exp)))

; analyze-ramb is the same as analyze-amb