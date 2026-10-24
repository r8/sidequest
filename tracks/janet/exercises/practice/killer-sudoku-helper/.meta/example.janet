# A cage is a struct {:sum sum :size size :exclude digits}.

(defn- choose
  "Ascending tuples of size distinct digits from digits that add up to total."
  [digits size total]
  (cond
    (zero? size) (if (zero? total) [[]] [])
    (empty? digits) []
    (let [[d & more] digits]
      [;(map |[d ;$] (choose more (dec size) (- total d)))
       ;(choose more size total)])))

(defn combinations
  "(combinations cage) -> each set of size distinct digits 1-9, none excluded, adding up to sum: ascending tuples, in ascending order"
  [cage]
  (def {:sum sum :size size :exclude exclude} cage)
  (choose (filter |(not (has-value? exclude $)) (range 1 10)) size sum))
