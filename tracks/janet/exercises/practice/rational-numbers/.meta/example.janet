# A rational number is a tuple [numerator denominator]. Every function returns it reduced to
# lowest terms with a positive denominator.
# `div` is core Janet's integer division, so the quotient is called `divide`.

(defn lowest-terms
  "(lowest-terms r) -> r in lowest terms with a positive denominator"
  [[a b]]
  (def g (* (math/abs (math/gcd a b)) (if (neg? b) -1 1)))
  [(/ a g) (/ b g)])

(defn add
  "(add r1 r2) -> the sum r1 + r2"
  [[a1 b1] [a2 b2]]
  (lowest-terms [(+ (* a1 b2) (* a2 b1)) (* b1 b2)]))

(defn subtract
  "(subtract r1 r2) -> the difference r1 - r2"
  [r1 [a2 b2]]
  (add r1 [(- a2) b2]))

(defn multiply
  "(multiply r1 r2) -> the product r1 * r2"
  [[a1 b1] [a2 b2]]
  (lowest-terms [(* a1 a2) (* b1 b2)]))

(defn divide
  "(divide r1 r2) -> the quotient r1 / r2"
  [r1 [a2 b2]]
  (multiply r1 [b2 a2]))

(defn abs
  "(abs r) -> the absolute value of r"
  [[a b]]
  (lowest-terms [(math/abs a) (math/abs b)]))

(defn exp-rational
  "(exp-rational r n) -> r raised to the integer power n"
  [[a b] n]
  (def m (math/abs n))
  (lowest-terms (if (neg? n)
            [(math/pow b m) (math/pow a m)]
            [(math/pow a m) (math/pow b m)])))

(defn exp-real
  "(exp-real x r) -> the real number x raised to the rational power r, as a number"
  [x [a b]]
  (math/pow x (/ a b)))
