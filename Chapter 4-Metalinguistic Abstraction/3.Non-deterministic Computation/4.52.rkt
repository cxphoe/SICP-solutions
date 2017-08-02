(define (if-fail? exp)
  (tagged-list? exp 'if-fail))

(define (if-fail-proc exp) (cadr exp))

(define (if-fail-fail exp) (caddr exp))

(define (analyze-if-fail exp)
  (let ((proc (analyze (if-fail-proc exp)))
        (fproc (analyze (if-fail-fail exp))))
    (lambda (env succeed fail)
      (proc env
            ;; success continuation for proc
            (lambda (val fail2)
              (succeed val fail2))
            ;; failure continuation for proc
            ;; call the fproc and wrap the 'fail' if failed
            (lambda ()
              (fproc env
                     ;; success continuation for fproc
                     succeed
                     ;; failure continuation for fproc
                     fail))))))