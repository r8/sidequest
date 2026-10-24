(defn price
  "(price &opt size) -> number; the price of a drink, medium unless said otherwise"
  [&opt size]
  (error "implement me"))

(defn price-with-extras
  "(price-with-extras size & extras) -> number; the price of a drink with its extras"
  [size & extras]
  (error "implement me"))

(defn describe-order
  "(describe-order drink &named size milk) -> string; the text of the order slip"
  [drink &named size milk]
  (error "implement me"))

(defn charge
  "(charge amount &opt promotion) -> number; the amount with the promotion applied"
  [amount &opt promotion]
  (error "implement me"))
