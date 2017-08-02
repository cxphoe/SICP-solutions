;Let's go through the concept.
;The basic element of simulation is wire:
(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))

    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    .....
    ))

;Wire contains two elements: signal-value and action-procedures.
;As we can see, everytimes a new procedure is added into the 
;action-procedures, it will also be called for initialization.
;take an instance:
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

;The accept-action-procedure! is designed to call the procedure added
;into itself. And a new lambda procedure that affect the output wire's
;signal-value will be added into agenda waiting for the call from
;propagate. If there is no initialization, we need to change the
;signal-value of a1 or a2 to active the procedure in the make-wire ---
;set-my-signal! so that all the procedures in action-procedures will be
;called, which will be a waste of labor.

;After setting up all the wires and connecting them, the whole simulation
;can be actived merely via the change of one single wire's signal-value.
;When signal-value of a wire is changed, the procedures in action-proce-
;dures will be called and some lambda procedures affecting relative
;output's signal-value will be added into agenda. If the output's
;signal-value is changed, some new procedures will added into agenda.
;So, the procedures setting for simulation are not put into agenda for
;once. They could be added due to the execution of the existed procedures

;So, the order of execution of the procedures in agenda will literally
;affect the final output.