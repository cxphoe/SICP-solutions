(load "apply-generic.rkt")

(define (install-equ?-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'equ? '(rational rational)
       (lambda (x y) (= (* (numer x) (denom y))
                        (* (numer y) (denom x)))))
  (put 'equ? '(complex complex)
       (lambda (x y) (and (= (real-part x) (real-part y))
                          (= (imag-part x) (imag-part y)))))
  (put 'equ? '(real-number real-number)
       (lambda (x y) (= x y)))
  'done)

(define (equ? x y) (apply-generic 'equ? x y))

(define (install-project-package)
  (define (complex->real x)
    (make-real-number (real-part x)))
  (define (real->rational x)
    (let ((rat (rationalize
                (inexact->exact x) 1/100)))
      (make-rational (numerator rat)
                     (denominator rat))))
  (define (rational->integar x)
    (make-scheme-number (round (/ (/ (numer x) 1.0)
                                  (denom x)))))
  
  (put 'project 'complex
       (lambda (x) (complex->real x)))
  (put 'project 'real-number
       (lambda (x) (real->rational x)))
  (put 'project 'rational
       (lambda (x) (rational->integar x)))
  'done)

(define (project x)
  ((get 'project (type-tag x)) (contents x)))

(define (drop x)
  (let ((lower (project x)))
    (if (and lower
             (equ? x (raise lower)))
        (drop lower)
        x)))