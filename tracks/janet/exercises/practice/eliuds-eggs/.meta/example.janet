(defn egg-count
  "(egg-count number) -> the number of 1 bits in number's binary representation"
  [number]
  (if (zero? number)
    0
    (+ (% number 2) (egg-count (div number 2)))))
