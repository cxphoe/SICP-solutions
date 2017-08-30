(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels
       (cdr text)
       (lambda (insts labels)
         (let ((nest-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)                    ; changed
                   (error "Multiple used label: " next-inst)   ;
                   (receive insts
                            (cons (make-label-entry next-inst insts)
                                  labels)))
               (receive (cons (make-instruction next-inst) insts)
                        labels)))))))