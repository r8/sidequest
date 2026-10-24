(def- grams-per
  "How many grams one of each unit weighs."
  {:g 1 :kg 1000 :oz 28 :lb 454})

(defn to-grams
  "(to-grams amount unit) -> the amount in grams; unit is :g, :kg, :oz or :lb"
  [amount unit]
  (* amount (grams-per unit)))

(defn format-grams
  "(format-grams grams) -> string such as \"250 g\" or \"1.5 kg\""
  [grams]
  (if (< grams 1000)
    (string grams " g")
    (string (/ grams 1000) " kg")))
