(def- numbers ["no" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"])

(defn- bottles [n]
  (string (numbers n) " green bottle" (if (= n 1) "" "s")))

(defn- capitalize [s]
  (string (string/ascii-upper (slice s 0 1)) (slice s 1)))

(defn- verse [n]
  (def line (capitalize (string (bottles n) " hanging on the wall,")))
  [line
   line
   "And if one green bottle should accidentally fall,"
   (string "There'll be " (bottles (- n 1)) " hanging on the wall.")])

(defn recite
  "(recite start-bottles take-down) -> an array of the lines of take-down verses counting down from start-bottles, with an empty line between verses"
  [start-bottles take-down]
  (def verses (map verse (range start-bottles (- start-bottles take-down) -1)))
  (array/slice (mapcat |["" ;$] verses) 1))
