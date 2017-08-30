;> (define i1 (make-interval 2 10))
;> (define i2 (make-interval -3 12))
;> (add-interval i1 i2)
;{mcons -1 22}
;> (mul-interval i1 i2)
;{mcons -30 120}
;> (div-interval i1 i2)
;{mcons -3.333333333333333 0.8333333333333333}
;> (sub-interval i1 i2)
;{mcons -10 13}