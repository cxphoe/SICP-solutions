(load "2.69.rkt")

(define ps '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))

(define song-tree (generate-huffman-tree ps))

(define song '(GET A JOB
               SHA NA NA NA NA NA NA NA NA
               GET A JOB
               SHA NA NA NA NA NA NA NA NA
               WAH YIP YIP YIP YIP YIP YIP YIP YIP
               SHA BOOM))

;(length song)
;(length (encode song song-tree))