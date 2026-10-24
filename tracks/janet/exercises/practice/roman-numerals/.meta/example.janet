(def- numerals
  [[1000 "M"] [900 "CM"] [500 "D"] [400 "CD"]
   [100 "C"] [90 "XC"] [50 "L"] [40 "XL"]
   [10 "X"] [9 "IX"] [5 "V"] [4 "IV"] [1 "I"]])

(defn roman
  "(roman number) -> number written in Roman numerals"
  [number]
  (if-let [[value letters] (find |(<= (first $) number) numerals)]
    (string letters (roman (- number value)))
    ""))
