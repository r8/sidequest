(defn clean-name
  "(clean-name raw) -> string, trimmed and lower-cased"
  [raw]
  (error "implement me"))

(defn ingredients
  "(ingredients order) -> array of the cleaned, non-empty ingredient names of a comma-separated order"
  [order]
  (error "implement me"))

(defn blend-price
  "(blend-price order prices) -> number, the total price of the order's ingredients"
  [order prices]
  (error "implement me"))

(defn free-smoothies
  "(free-smoothies customers name) -> integer, or nil for an unknown customer or one without :stamps"
  [customers name]
  (error "implement me"))

(defn receipt
  "(receipt order prices) -> string such as \"mango + kiwi = 5\""
  [order prices]
  (error "implement me"))
