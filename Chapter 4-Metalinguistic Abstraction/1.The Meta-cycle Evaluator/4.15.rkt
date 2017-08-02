(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))
;; Just ignore the exact implementation of halts?
;; for (try try), if (halts? p p) return true, it means the try can halt to try,
;; but exactly (try try) will return (run-forever) if (halts? p p) is true, which
;; contracdict with the conclusion we've already got.