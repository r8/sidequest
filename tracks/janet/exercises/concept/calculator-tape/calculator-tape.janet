(defn parse-amount
  "(parse-amount text) -> number or nil"
  [text]
  (error "implement me"))

(defn parse-entry
  "(parse-entry line) -> [operator amount] or nil; operator is :add, :sub, :mul or :div"
  [line]
  (error "implement me"))

(defn parse-tape
  "(parse-tape tape) -> array of entries, or nil if any line is not an entry"
  [tape]
  (error "implement me"))

(defn tape-total
  "(tape-total tape) -> number; the entries applied in order, starting from 0"
  [tape]
  (error "implement me"))

(defn evaluate
  "(evaluate text) -> integer or nil; a sum of whole numbers with + - and parentheses"
  [text]
  (error "implement me"))
