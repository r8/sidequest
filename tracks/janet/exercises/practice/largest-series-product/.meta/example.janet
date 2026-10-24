(defn largest-product
  "(largest-product digits span) -> the largest product of span adjacent digits in the digits string"
  [digits span]
  (when (neg? span) (error "span must not be negative"))
  (when (> span (length digits)) (error "span must not exceed string length"))
  (unless (peg/match ~(* :d* -1) digits) (error "digits input must only contain digits"))
  (def ds (map |(- $ (chr "0")) digits))
  (max-of (seq [i :range-to [0 (- (length ds) span)]]
            (product (slice ds i (+ i span))))))
