(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x entry) true)
        ((< x entry) (element-of-set? x (left-branch set)))
        (else
         (element-of-set? x (right-branch set)))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

; a)
; the result of two method is the same: transform a tree into a ordered list
; b)
; the step of first grows faster because of procedure 'append'
; while the second one's is O(n)

(define t (make-tree 7
                     (make-tree 3
                                (make-tree 1 nil nil)
                                (make-tree 5 nil nil))
                     (make-tree 9
                                nil
                                (make-tree 11 nil nil))))