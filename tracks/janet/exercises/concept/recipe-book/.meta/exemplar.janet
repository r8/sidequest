(import ./units)

(defn- grams-of
  "The weight in grams of one [name amount unit] line of a recipe."
  [line]
  (units/to-grams (line 1) (line 2)))

(defn in-grams
  "(in-grams recipe) -> table from each ingredient's name to its weight in grams"
  [recipe]
  (def weights @{})
  (each line recipe
    (put weights (line 0) (grams-of line)))
  weights)

(defn shopping-list
  "(shopping-list recipe factor) -> array of lines such as \"flour: 1.5 kg\" for the recipe scaled by factor"
  [recipe factor]
  (def lines @[])
  (each line recipe
    (array/push lines (string (line 0) ": " (units/format-grams (* factor (grams-of line))))))
  lines)

(defn total-weight
  "(total-weight recipe) -> string, the recipe's total weight formatted like format-grams"
  [recipe]
  (var total 0)
  (each line recipe
    (+= total (grams-of line)))
  (units/format-grams total))
