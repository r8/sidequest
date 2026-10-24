(defn slices
  "(slices series len) -> every contiguous substring of series of length len, in order"
  [series len]
  (cond
    (empty? series) (error "series cannot be empty")
    (zero? len) (error "slice length cannot be zero")
    (neg? len) (error "slice length cannot be negative")
    (> len (length series)) (error "slice length cannot be greater than series length"))
  (seq [i :range-to [0 (- (length series) len)]]
    (string/slice series i (+ i len))))
