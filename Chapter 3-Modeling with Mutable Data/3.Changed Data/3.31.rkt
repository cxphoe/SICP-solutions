;the question 3.31 is about what would happed if accept-action-procedure!
;is defined as follow:
(define (accept-action-procedure! proc)
  (set! action-procedures (cons proc action-procedures)))

;take and-gate's defination as example:
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

;the procedures seem all call after-delay procedure at the end which I
;suppose it's about adding a lambda procedure into the agenda that is
;used for the all signal transmission during simulation.

;So the agenda that we defined will not have the record of those
;lambda procedures (those about setting signal) in the procedures
;(like and-action-procedure), if we do not call the procedure as we
;add it to the wire's own action-procedures.

;It means the simulation will not work when agenda is simualted via
;propagate