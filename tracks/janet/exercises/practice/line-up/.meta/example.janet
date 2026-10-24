(defn- suffix [n]
  (if (<= 11 (% n 100) 13)
    "th"
    (case (% n 10) 1 "st" 2 "nd" 3 "rd" "th")))

(defn format
  "(format name number) -> the greeting telling name they are the number-th customer, with the ordinal suffix"
  [name number]
  (string name ", you are the " number (suffix number) " customer we serve today. Thank you!"))
