(rule (can-do ?job1 ?job2)
      (or (same ?job1 ?job2)
          (and (can-do-job ?job1 ?sub-job1)
               (can-do ?sub-job1 ?job2))))

(rule (replace ?person1 ?person2)
      (and (job ?person1 ?job1)
           (job ?person2 ?job2)
           (can-do? ?job1 ?job2)
           (not (same ?person1 ?person2))))

;; a)
(replaceable ?p (Fect Cy D))

;; b)
(and (salary ?person1 ?amount1)
     (salary ?person2 ?amount2)
     (replace ?p ?person1)
     (lisp-value > ?amount1 ?amount2))