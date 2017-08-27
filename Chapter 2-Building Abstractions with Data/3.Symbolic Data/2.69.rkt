(load "2.68.rkt")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (null? (cdr leaf-set))
      (car leaf-set)
      (successive-merge
       (adjoin-set (make-code-tree (car leaf-set)
                                   (cadr leaf-set))
                   (cddr leaf-set)))))
; adjoin-set here ensure the order won't be messed up after
; we have combine two leaves, which means the two leaves with
; smallest weight will be considered first.

(define pairs1 '((A 4) (B 2) (C 1) (D 1)))
(define pairs2 '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1)))

(define t1 (generate-huffman-tree pairs1))
(define t2 (generate-huffman-tree pairs2))
