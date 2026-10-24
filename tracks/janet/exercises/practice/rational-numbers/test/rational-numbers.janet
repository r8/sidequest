(import test :as t)
(import ../rational-numbers :as sol)

(defn- assert-close
  "Passes when the number `actual` is within 1e-9 of `expected`."
  [expected actual]
  (t/assert-true (and (number? actual) (< (math/abs (- expected actual)) 1e-9))
                 (string/format "expected %q (within 1e-9), got %q" expected actual)))

(t/deftest "Add two positive rational numbers"
  (t/assert-equal [7 6] (sol/add [1 2] [2 3])))

(t/deftest "Add a positive rational number and a negative rational number"
  (t/assert-equal [-1 6] (sol/add [1 2] [-2 3])))

(t/deftest "Add two negative rational numbers"
  (t/assert-equal [-7 6] (sol/add [-1 2] [-2 3])))

(t/deftest "Add a rational number to its additive inverse"
  (t/assert-equal [0 1] (sol/add [1 2] [-1 2])))

(t/deftest "Subtract two positive rational numbers"
  (t/assert-equal [-1 6] (sol/subtract [1 2] [2 3])))

(t/deftest "Subtract a positive rational number and a negative rational number"
  (t/assert-equal [7 6] (sol/subtract [1 2] [-2 3])))

(t/deftest "Subtract two negative rational numbers"
  (t/assert-equal [1 6] (sol/subtract [-1 2] [-2 3])))

(t/deftest "Subtract a rational number from itself"
  (t/assert-equal [0 1] (sol/subtract [1 2] [1 2])))

(t/deftest "Multiply two positive rational numbers"
  (t/assert-equal [1 3] (sol/multiply [1 2] [2 3])))

(t/deftest "Multiply a negative rational number by a positive rational number"
  (t/assert-equal [-1 3] (sol/multiply [-1 2] [2 3])))

(t/deftest "Multiply two negative rational numbers"
  (t/assert-equal [1 3] (sol/multiply [-1 2] [-2 3])))

(t/deftest "Multiply a rational number by its reciprocal"
  (t/assert-equal [1 1] (sol/multiply [1 2] [2 1])))

(t/deftest "Multiply a rational number by 1"
  (t/assert-equal [1 2] (sol/multiply [1 2] [1 1])))

(t/deftest "Multiply a rational number by 0"
  (t/assert-equal [0 1] (sol/multiply [1 2] [0 1])))

(t/deftest "Divide two positive rational numbers"
  (t/assert-equal [3 4] (sol/divide [1 2] [2 3])))

(t/deftest "Divide a positive rational number by a negative rational number"
  (t/assert-equal [-3 4] (sol/divide [1 2] [-2 3])))

(t/deftest "Divide two negative rational numbers"
  (t/assert-equal [3 4] (sol/divide [-1 2] [-2 3])))

(t/deftest "Divide a rational number by 1"
  (t/assert-equal [1 2] (sol/divide [1 2] [1 1])))

(t/deftest "Absolute value of a positive rational number"
  (t/assert-equal [1 2] (sol/abs [1 2])))

(t/deftest "Absolute value of a positive rational number with negative numerator and denominator"
  (t/assert-equal [1 2] (sol/abs [-1 -2])))

(t/deftest "Absolute value of a negative rational number"
  (t/assert-equal [1 2] (sol/abs [-1 2])))

(t/deftest "Absolute value of a negative rational number with negative denominator"
  (t/assert-equal [1 2] (sol/abs [1 -2])))

(t/deftest "Absolute value of zero"
  (t/assert-equal [0 1] (sol/abs [0 1])))

(t/deftest "Absolute value of a rational number is reduced to lowest terms"
  (t/assert-equal [1 2] (sol/abs [2 4])))

(t/deftest "Raise a positive rational number to a positive integer power"
  (t/assert-equal [1 8] (sol/exp-rational [1 2] 3)))

(t/deftest "Raise a negative rational number to a positive integer power"
  (t/assert-equal [-1 8] (sol/exp-rational [-1 2] 3)))

(t/deftest "Raise a positive rational number to a negative integer power"
  (t/assert-equal [25 9] (sol/exp-rational [3 5] -2)))

(t/deftest "Raise a negative rational number to an even negative integer power"
  (t/assert-equal [25 9] (sol/exp-rational [-3 5] -2)))

(t/deftest "Raise a negative rational number to an odd negative integer power"
  (t/assert-equal [-125 27] (sol/exp-rational [-3 5] -3)))

(t/deftest "Raise zero to an integer power"
  (t/assert-equal [0 1] (sol/exp-rational [0 1] 5)))

(t/deftest "Raise one to an integer power"
  (t/assert-equal [1 1] (sol/exp-rational [1 1] 4)))

(t/deftest "Raise a positive rational number to the power of zero"
  (t/assert-equal [1 1] (sol/exp-rational [1 2] 0)))

(t/deftest "Raise a negative rational number to the power of zero"
  (t/assert-equal [1 1] (sol/exp-rational [-1 2] 0)))

(t/deftest "Raise a real number to a positive rational number"
  (assert-close 16 (sol/exp-real 8 [4 3])))

(t/deftest "Raise a real number to a negative rational number"
  (assert-close 0.3333333333333333 (sol/exp-real 9 [-1 2])))

(t/deftest "Raise a real number to a zero rational number"
  (assert-close 1 (sol/exp-real 2 [0 1])))

(t/deftest "Reduce a positive rational number to lowest terms"
  (t/assert-equal [1 2] (sol/lowest-terms [2 4])))

(t/deftest "Reduce places the minus sign on the numerator"
  (t/assert-equal [-3 4] (sol/lowest-terms [3 -4])))

(t/deftest "Reduce a negative rational number to lowest terms"
  (t/assert-equal [-2 3] (sol/lowest-terms [-4 6])))

(t/deftest "Reduce a rational number with a negative denominator to lowest terms"
  (t/assert-equal [-1 3] (sol/lowest-terms [3 -9])))

(t/deftest "Reduce zero to lowest terms"
  (t/assert-equal [0 1] (sol/lowest-terms [0 6])))

(t/deftest "Reduce an integer to lowest terms"
  (t/assert-equal [-2 1] (sol/lowest-terms [-14 7])))

(t/deftest "Reduce one to lowest terms"
  (t/assert-equal [1 1] (sol/lowest-terms [13 13])))

(t/run)
