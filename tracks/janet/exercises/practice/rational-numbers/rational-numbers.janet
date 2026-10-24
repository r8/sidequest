# A rational number is a tuple [numerator denominator]. Every function returns it reduced to
# lowest terms with a positive denominator.
# `div` is core Janet's integer division, so the quotient is called `divide`.

(defn add
  "(add r1 r2) -> the sum r1 + r2"
  [r1 r2]
  (error "implement me"))

(defn subtract
  "(subtract r1 r2) -> the difference r1 - r2"
  [r1 r2]
  (error "implement me"))

(defn multiply
  "(multiply r1 r2) -> the product r1 * r2"
  [r1 r2]
  (error "implement me"))

(defn divide
  "(divide r1 r2) -> the quotient r1 / r2"
  [r1 r2]
  (error "implement me"))

(defn abs
  "(abs r) -> the absolute value of r"
  [r]
  (error "implement me"))

(defn exp-rational
  "(exp-rational r n) -> r raised to the integer power n"
  [r n]
  (error "implement me"))

(defn exp-real
  "(exp-real x r) -> the real number x raised to the rational power r, as a number"
  [x r]
  (error "implement me"))

(defn lowest-terms
  "(lowest-terms r) -> r in lowest terms with a positive denominator"
  [r]
  (error "implement me"))
