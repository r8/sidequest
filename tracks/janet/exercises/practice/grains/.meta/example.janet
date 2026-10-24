# Square 64 holds 2^63 grains, beyond the 2^53 a Janet number (a double) holds exactly,
# so both functions return a 64-bit unsigned integer: (int/u64 ...).

(defn square
  "(square n) -> the grains on square n as an int/u64; errors unless 1 <= n <= 64"
  [n]
  (unless (<= 1 n 64)
    (error "square must be between 1 and 64"))
  (blshift (int/u64 1) (- n 1)))

(defn total
  "(total) -> the grains on the whole board as an int/u64"
  []
  (sum (map square (range 1 65))))
