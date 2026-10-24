# A result is a struct like {:value 9 :factors [[1 9] [3 3]]}: the palindrome and every pair of
# factors in [min, max] that multiply to it. When there is no such palindrome, the result is nil.

(defn- palindrome? [n]
  (def s (string n))
  (= s (string/reverse s)))

(defn- check-range [min max]
  (when (> min max)
    (error "min must be <= max")))

(defn- result [value min max]
  (when value
    {:value value
     :factors (if (zero? value)
                # Only a range starting at 0 has the product 0, and 0 times anything is 0.
                (seq [b :range-to [min max]] [0 b])
                (seq [a :range-to [min (math/sqrt value)]
                      :when (zero? (% value a))
                      :let [b (/ value a)]
                      :when (<= b max)]
                  [a b]))}))

(defn smallest
  "(smallest min max) -> the smallest palindrome product of factors in [min, max], or nil; errors if min > max"
  [min max]
  (check-range min max)
  (var best nil)
  # Products only grow along each row, so stop a row (or the whole search) once it can't beat best.
  (loop [a :range-to [min max]
         :until (and best (>= (* a a) best))
         b :range-to [a max]
         :until (and best (>= (* a b) best))
         :when (palindrome? (* a b))]
    (set best (* a b)))
  (result best min max))

(defn largest
  "(largest min max) -> the largest palindrome product of factors in [min, max], or nil; errors if min > max"
  [min max]
  (check-range min max)
  (var best nil)
  # Products only shrink along each row, so stop a row (or the whole search) once it can't beat best.
  (loop [a :down-to [max min]
         :until (and best (<= (* a max) best))
         b :down-to [max a]
         :until (and best (<= (* a b) best))
         :when (palindrome? (* a b))]
    (set best (* a b)))
  (result best min max))
