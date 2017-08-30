(rule (reverse () ()))

(rule (reverse (?x . ?y) ?z)
      (and (reverse ?y ?v)
           (append-to-form ?v (?x) ?z)))