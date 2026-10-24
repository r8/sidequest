(defn clean-name
  "(clean-name raw) -> string, trimmed and lower-cased"
  [raw]
  (-> raw string/trim string/ascii-lower))

(defn ingredients
  "(ingredients order) -> array of the cleaned, non-empty ingredient names of a comma-separated order"
  [order]
  (->> order
       (string/split ",")
       (map clean-name)
       (filter |(not (empty? $)))))

(defn blend-price
  "(blend-price order prices) -> number, the total price of the order's ingredients"
  [order prices]
  (->> (ingredients order)
       (map |(get prices $))
       sum))

(defn free-smoothies
  "(free-smoothies customers name) -> integer, or nil for an unknown customer or one without :stamps"
  [customers name]
  (-?> customers (get name) (get :stamps) (div 10)))

(defn receipt
  "(receipt order prices) -> string such as \"mango + kiwi = 5\""
  [order prices]
  (-> (ingredients order)
      (string/join " + ")
      (string " = " (blend-price order prices))))
