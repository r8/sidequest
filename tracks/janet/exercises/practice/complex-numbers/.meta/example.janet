# A complex number a + b * i is a tuple [a b]. Wherever a function takes a complex number it
# also accepts a plain real number, 5 meaning [5 0].
# `div` is core Janet's integer division, so the quotient is called `divide`.

(defn- complex [z] (if (number? z) [z 0] z))

(defn real
  "(real z) -> the real part of z"
  [z]
  ((complex z) 0))

(defn imaginary
  "(imaginary z) -> the imaginary part of z"
  [z]
  ((complex z) 1))

(defn add
  "(add z1 z2) -> the sum z1 + z2"
  [z1 z2]
  (def [a b] (complex z1))
  (def [c d] (complex z2))
  [(+ a c) (+ b d)])

(defn subtract
  "(subtract z1 z2) -> the difference z1 - z2"
  [z1 z2]
  (def [c d] (complex z2))
  (add z1 [(- c) (- d)]))

(defn multiply
  "(multiply z1 z2) -> the product z1 * z2"
  [z1 z2]
  (def [a b] (complex z1))
  (def [c d] (complex z2))
  [(- (* a c) (* b d)) (+ (* b c) (* a d))])

(defn divide
  "(divide z1 z2) -> the quotient z1 / z2"
  [z1 z2]
  (def [a b] (complex z1))
  (def [c d] (complex z2))
  (def denominator (+ (* c c) (* d d)))
  [(/ (+ (* a c) (* b d)) denominator) (/ (- (* b c) (* a d)) denominator)])

(defn abs
  "(abs z) -> the absolute value (modulus) of z, a real number"
  [z]
  (def [a b] (complex z))
  (math/hypot a b))

(defn conjugate
  "(conjugate z) -> the complex conjugate of z"
  [z]
  (def [a b] (complex z))
  [a (- b)])

(defn exp
  "(exp z) -> e raised to the power z"
  [z]
  # Euler's formula: e^(a + b * i) = e^a * (cos b + i * sin b)
  (def [a b] (complex z))
  (multiply (math/exp a) [(math/cos b) (math/sin b)]))
