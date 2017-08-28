; use the procedure equ? defined in question 2.79
; plus the equ? for real-number
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

; 2.85
(define (install-project-package)
  (define (complex->real x)
    (make-real-number (real-part x)))
  (define (real->rational x)
    (let ((rat (rationalize
                (inexact->exact x) 1/100)))
      (make-rational (numerator rat)
                     (denominator rat))))
  (define (rational->scheme-number x)
    (make-scheme-number (round (/ (/ (numer x) 1.0)
                                  (denom x)))))
  
  (put 'project 'complex
       (lambda (x) (complex->real x)))
  (put 'project 'real-number
       (lambda (x) (real->rational x)))
  (put 'project 'rational
       (lambda (x) (rational->scheme-number x)))
  'done)

(define (project x) (apply-generic 'project x))

(define (drop x)
  (if (pair? x)
      (let ((type (type-tag x)))
        (cond ((eq? type 'scheme-number) x)  ; no project for integar
              ((eq? x (raise (project x)))
               (drop (project x)))
              (else x)))
      x)) ; #t or #f

(load "2.84.rkt")

; redefine apply-generic
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (let ((res (apply proc (map contents args))))  ; redefined part
            (if (or (eq? op 'drop)                       ;
                    (eq? op 'raise)                      ;
                    (eq? op 'project))                   ;
                res                                      ;
                (drop res)))                             ;
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (and (not (eq? type1 type2))
                     (= (length args) 2))
                (let ((a1-upper (raise-up a1 a2))
                      (a2-upper (raise-up a2 a1)))
                  (cond (a1-upper
                         (apply-generic op a1-upper a2))
                        (a2-upper
                         (apply-generic op a1 a2-upper))
                        (else
                         (error "No method for these types"
                                (list op type-tags)))))
                (error "No method for these types"
                       (list op type-tags))))))))