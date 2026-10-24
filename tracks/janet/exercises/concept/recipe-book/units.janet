# Keep the table of conversion factors, grams-per, private to this module.

(defn to-grams
  "(to-grams amount unit) -> the amount in grams; unit is :g, :kg, :oz or :lb"
  [amount unit]
  (error "implement me"))

(defn format-grams
  "(format-grams grams) -> string such as \"250 g\" or \"1.5 kg\""
  [grams]
  (error "implement me"))
