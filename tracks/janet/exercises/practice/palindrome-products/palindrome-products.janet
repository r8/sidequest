# A result is a struct like {:value 9 :factors [[1 9] [3 3]]}: the palindrome and every pair of
# factors in [min, max] that multiply to it. When there is no such palindrome, the result is nil.

(defn smallest
  "(smallest min max) -> the smallest palindrome product of factors in [min, max], or nil; errors if min > max"
  [min max]
  (error "implement me"))

(defn largest
  "(largest min max) -> the largest palindrome product of factors in [min, max], or nil; errors if min > max"
  [min max]
  (error "implement me"))
