(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((set-entry (entry set-of-records)))
        (cond ((= given-key (key set-entry))
               set-entry)
              ((< given-key (key set-entry))
               (lookup given-key (left-branch set-of-records)))
              ((> given-key (key set-entry))
               (lookup given-key (right-branch set-of-records)))
              (else
               (error "wrong key type" given-key))))))