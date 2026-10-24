# A complex number a + b * i is a tuple [a b]. Wherever a function takes a complex number it
# also accepts a plain real number, 5 meaning [5 0].
# `div` is core Janet's integer division, so the quotient is called `divide`.

(defn real
  "(real z) -> the real part of z"
  [z]
  (error "implement me"))

(defn imaginary
  "(imaginary z) -> the imaginary part of z"
  [z]
  (error "implement me"))

(defn add
  "(add z1 z2) -> the sum z1 + z2"
  [z1 z2]
  (error "implement me"))

(defn subtract
  "(subtract z1 z2) -> the difference z1 - z2"
  [z1 z2]
  (error "implement me"))

(defn multiply
  "(multiply z1 z2) -> the product z1 * z2"
  [z1 z2]
  (error "implement me"))

(defn divide
  "(divide z1 z2) -> the quotient z1 / z2"
  [z1 z2]
  (error "implement me"))

(defn abs
  "(abs z) -> the absolute value (modulus) of z, a real number"
  [z]
  (error "implement me"))

(defn conjugate
  "(conjugate z) -> the complex conjugate of z"
  [z]
  (error "implement me"))

(defn exp
  "(exp z) -> e raised to the power z"
  [z]
  (error "implement me"))
