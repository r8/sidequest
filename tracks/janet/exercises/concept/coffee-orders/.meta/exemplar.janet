(defn price
  "(price &opt size) -> number; the price of a drink, medium unless said otherwise"
  [&opt size]
  (default size :medium)
  (case size
    :small 3
    :medium 4
    :large 5))

(defn price-with-extras
  "(price-with-extras size & extras) -> number; the price of a drink with its extras"
  [size & extras]
  (+ (price size) (* 0.5 (length extras))))

(defn describe-order
  "(describe-order drink &named size milk) -> string; the text of the order slip"
  [drink &named size milk]
  (default size :medium)
  (string size " " (if milk (string milk " ") "") drink))

(defn charge
  "(charge amount &opt promotion) -> number; the amount with the promotion applied"
  [amount &opt promotion]
  (if promotion
    (promotion amount)
    amount))
