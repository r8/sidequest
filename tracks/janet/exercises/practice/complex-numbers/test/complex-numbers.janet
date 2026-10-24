(import test :as t)
(import ../complex-numbers :as sol)

(defn- assert-close
  "Passes when the complex number `actual` is within 1e-9 of `expected` in both parts."
  [expected actual]
  (t/assert-true (and (indexed? actual)
                      (= 2 (length actual))
                      (all |(< (math/abs (- $0 $1)) 1e-9) expected actual))
                 (string/format "expected %q (within 1e-9), got %q" expected actual)))

(t/deftest "Real part of a purely real number"
  (t/assert-equal 1 (sol/real [1 0])))

(t/deftest "Real part of a purely imaginary number"
  (t/assert-equal 0 (sol/real [0 1])))

(t/deftest "Real part of a number with real and imaginary part"
  (t/assert-equal 1 (sol/real [1 2])))

(t/deftest "Imaginary part of a purely real number"
  (t/assert-equal 0 (sol/imaginary [1 0])))

(t/deftest "Imaginary part of a purely imaginary number"
  (t/assert-equal 1 (sol/imaginary [0 1])))

(t/deftest "Imaginary part of a number with real and imaginary part"
  (t/assert-equal 2 (sol/imaginary [1 2])))

(t/deftest "Imaginary unit"
  (t/assert-equal [-1 0] (sol/multiply [0 1] [0 1])))

(t/deftest "Add purely real numbers"
  (t/assert-equal [3 0] (sol/add [1 0] [2 0])))

(t/deftest "Add purely imaginary numbers"
  (t/assert-equal [0 3] (sol/add [0 1] [0 2])))

(t/deftest "Add numbers with real and imaginary part"
  (t/assert-equal [4 6] (sol/add [1 2] [3 4])))

(t/deftest "Subtract purely real numbers"
  (t/assert-equal [-1 0] (sol/subtract [1 0] [2 0])))

(t/deftest "Subtract purely imaginary numbers"
  (t/assert-equal [0 -1] (sol/subtract [0 1] [0 2])))

(t/deftest "Subtract numbers with real and imaginary part"
  (t/assert-equal [-2 -2] (sol/subtract [1 2] [3 4])))

(t/deftest "Multiply purely real numbers"
  (t/assert-equal [2 0] (sol/multiply [1 0] [2 0])))

(t/deftest "Multiply purely imaginary numbers"
  (t/assert-equal [-2 0] (sol/multiply [0 1] [0 2])))

(t/deftest "Multiply numbers with real and imaginary part"
  (t/assert-equal [-5 10] (sol/multiply [1 2] [3 4])))

(t/deftest "Divide purely real numbers"
  (assert-close [0.5 0] (sol/divide [1 0] [2 0])))

(t/deftest "Divide purely imaginary numbers"
  (assert-close [0.5 0] (sol/divide [0 1] [0 2])))

(t/deftest "Divide numbers with real and imaginary part"
  (assert-close [0.44 0.08] (sol/divide [1 2] [3 4])))

(t/deftest "Absolute value of a positive purely real number"
  (t/assert-equal 5 (sol/abs [5 0])))

(t/deftest "Absolute value of a negative purely real number"
  (t/assert-equal 5 (sol/abs [-5 0])))

(t/deftest "Absolute value of a purely imaginary number with positive imaginary part"
  (t/assert-equal 5 (sol/abs [0 5])))

(t/deftest "Absolute value of a purely imaginary number with negative imaginary part"
  (t/assert-equal 5 (sol/abs [0 -5])))

(t/deftest "Absolute value of a number with real and imaginary part"
  (t/assert-equal 5 (sol/abs [3 4])))

(t/deftest "Conjugate a purely real number"
  (t/assert-equal [5 0] (sol/conjugate [5 0])))

(t/deftest "Conjugate a purely imaginary number"
  (t/assert-equal [0 -5] (sol/conjugate [0 5])))

(t/deftest "Conjugate a number with real and imaginary part"
  (t/assert-equal [1 -1] (sol/conjugate [1 1])))

(t/deftest "Euler's identity/formula"
  (assert-close [-1 0] (sol/exp [0 math/pi])))

(t/deftest "Exponential of 0"
  (assert-close [1 0] (sol/exp [0 0])))

(t/deftest "Exponential of a purely real number"
  (assert-close [math/e 0] (sol/exp [1 0])))

(t/deftest "Exponential of a number with real and imaginary part"
  (assert-close [-2 0] (sol/exp [(math/log 2) math/pi])))

(t/deftest "Exponential resulting in a number with real and imaginary part"
  (assert-close [1 1] (sol/exp [(/ (math/log 2) 2) (/ math/pi 4)])))

(t/deftest "Add real number to complex number"
  (t/assert-equal [6 2] (sol/add [1 2] 5)))

(t/deftest "Add complex number to real number"
  (t/assert-equal [6 2] (sol/add 5 [1 2])))

(t/deftest "Subtract real number from complex number"
  (t/assert-equal [1 7] (sol/subtract [5 7] 4)))

(t/deftest "Subtract complex number from real number"
  (t/assert-equal [-1 -7] (sol/subtract 4 [5 7])))

(t/deftest "Multiply complex number by real number"
  (t/assert-equal [10 25] (sol/multiply [2 5] 5)))

(t/deftest "Multiply real number by complex number"
  (t/assert-equal [10 25] (sol/multiply 5 [2 5])))

(t/deftest "Divide complex number by real number"
  (assert-close [1 10] (sol/divide [10 100] 10)))

(t/deftest "Divide real number by complex number"
  (assert-close [2.5 -2.5] (sol/divide 5 [1 1])))

(t/run)
