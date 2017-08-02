(load "expression.rkt")
(load "table.rkt")
(load "record-operation.rkt")

;--------------------------------------------------;

;; assertions
(define THE-ASSERTIONS '())

(define (fetch-assertions pattern frame)
  ;; fetch assertions with or without index
  (if (use-index? pattern)
      (get-indexed-assertions pattern)
      (get-all-assertions)))

(define (get-all-assertions) THE-ASSERTIONS)

(define (get-indexed-assertions pattern)
  (get-record (index-key-of pattern) 'assertion-record))

(define (get-record key1 key2)
  (let ((s (get key1 key2)))
    (if s s '())))

;; rules
(define THE-RULES '())

(define (fetch-rules pattern frame)
  (if (use-index? pattern)
      (get-indexed-rules pattern)
      (get-all-rules)))

(define (get-all-rules) THE-RULES)

(define (get-indexed-rules pattern)
  (append
   (get-record (index-key-of pattern) 'rule-record)
   (get-record '? 'rule-record)))

;; operation
(define (add-rule-or-assertion! assertion)
  (if (rule? assertion)
      (add-rule! assertion)
      (add-assertion! assertion)))

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)    ; store it with index
  (let ((old-assertions THE-ASSERTIONS))  ; store it simply
    (set! THE-ASSERTIONS
          (cons assertion old-assertions))
    'ok))

(define (add-rule! rule)
  (store-rule-in-index rule)
  (let ((old-rules THE-RULES))
    (set! THE-RULES (cons rule old-rules))
    'ok))

(define (store-assertion-in-index assertion)
  ;; the assertions with same index will be stored in
  ;; the same place in operation table (table.rkt).
  (if (indexable? assertion)
      (let ((key (index-key-of assertion)))
        (let ((current-assertion-record
               (get-record key 'assertion-record)))
          (put key
               'assertion-record
               (cons assertion
                     current-assertion-record))))))

(define (store-rule-in-index rule)
  (let ((pattern (conclusion rule)))
    (if (indexable? pattern)
        (let ((key (index-key-of pattern)))
          (let ((current-rule-record
                 (get-record key 'rule-record)))
            (put key
                 'rule-record
                 (cons rule
                       current-rule-record)))))))

(define (indexable? pat)
  (or (constant-symbol? (car pat))
      (var? (car pat))))

(define (index-key-of pat)
  (let ((key (car pat)))
    (if (var? key) '? key)))

(define (use-index? pat)
  (constant-symbol? (car pat)))