(def amount ~(number (* (? "-") :d+ (? (* "." :d+)))))

(def entry
  ~(group (* (+ (/ "+" :add) (/ "-" :sub) (/ "*" :mul) (/ "/" :div))
             (some " ")
             ,amount)))

(def tape
  (peg/compile
    ~{:entry ,entry
      :main (* :entry (any (* "\n" :entry)) (? "\n") -1)}))

(defn fold
  "Applies each [operator term] pair to the running value, from left to right."
  [first & steps]
  (reduce (fn [acc [op term]] (op acc term)) first steps))

(def sum
  (peg/compile
    ~{:ws (any " ")
      :number (number (* (? "-") :d+))
      :term (+ :number (* "(" :ws :sum :ws ")"))
      :operator (+ (* "+" (constant ,+)) (* "-" (constant ,-)))
      :sum (/ (* :term (any (group (* :ws :operator :ws :term)))) ,fold)
      :main (* :ws :sum :ws -1)}))

(defn parse-amount
  "(parse-amount text) -> number or nil"
  [text]
  (get (peg/match ~(* ,amount -1) text) 0))

(defn parse-entry
  "(parse-entry line) -> [operator amount] or nil; operator is :add, :sub, :mul or :div"
  [line]
  (get (peg/match ~(* ,entry -1) line) 0))

(defn parse-tape
  "(parse-tape tape) -> array of entries, or nil if any line is not an entry"
  [text]
  (peg/match tape text))

(defn apply-entry [total [op n]]
  (case op
    :add (+ total n)
    :sub (- total n)
    :mul (* total n)
    :div (/ total n)))

(defn tape-total
  "(tape-total tape) -> number; the entries applied in order, starting from 0"
  [text]
  (reduce apply-entry 0 (parse-tape text)))

(defn evaluate
  "(evaluate text) -> integer or nil; a sum of whole numbers with + - and parentheses"
  [text]
  (get (peg/match sum text) 0))
