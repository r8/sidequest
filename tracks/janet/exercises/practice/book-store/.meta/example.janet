# Price in cents of a group of 0-5 different books.
(def- group-price [0 800 1520 2160 2560 3000])

(defn- remove-group
  "Takes one copy from each of the k most plentiful titles; counts stay sorted, largest first."
  [counts k]
  (tuple ;(sort (filter pos? [;(map dec (take k counts)) ;(drop k counts)]) >)))

(defn total
  "(total basket) -> the lowest price in cents for the basket, a list of book numbers 1-5"
  [basket]
  (def memo @{})
  (defn cost [counts]
    (if (empty? counts)
      0
      (or (memo counts)
          (set (memo counts)
               (min ;(seq [k :range-to [1 (length counts)]]
                       (+ (group-price k) (cost (remove-group counts k)))))))))
  (cost (tuple ;(sort (values (frequencies basket)) >))))
