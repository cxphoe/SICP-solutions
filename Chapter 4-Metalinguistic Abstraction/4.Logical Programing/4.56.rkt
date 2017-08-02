;; a)
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

;; b)
(and (salary (Bitdiddle Ben) ?amount1)
     (salary ?person ?amount2)
     (lisp-value < amount2 amount1))

;; c)
(and (supervisor ?person ?super)
     (not (job ?super (computer . ?type)))
     (job ?person ?job))