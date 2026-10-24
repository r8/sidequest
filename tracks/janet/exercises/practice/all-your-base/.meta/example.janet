(defn- to-digits [n base]
  (if (< n base)
    @[n]
    (array/push (to-digits (div n base) base) (% n base))))

(defn rebase
  "(rebase input-base digits output-base) -> the digits, most significant first, of the same number in output-base"
  [input-base digits output-base]
  (when (< input-base 2) (error "input base must be >= 2"))
  (unless (all |(<= 0 $ (dec input-base)) digits)
    (error "all digits must satisfy 0 <= d < input base"))
  (when (< output-base 2) (error "output base must be >= 2"))
  (to-digits (reduce (fn [n d] (+ (* n input-base) d)) 0 digits) output-base))
