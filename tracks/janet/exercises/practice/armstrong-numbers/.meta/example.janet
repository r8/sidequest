(defn armstrong-number?
  "(armstrong-number? number) -> true when number is the sum of its digits each raised to the number of digits"
  [number]
  (def digits (map |(- $ (chr "0")) (string number)))
  (= number (sum (map |(math/pow $ (length digits)) digits))))
