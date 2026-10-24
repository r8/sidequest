(import test :as t)
(import ../say :as sol)

(t/deftest "zero"
  (t/assert-equal "zero" (sol/say 0)))

(t/deftest "one"
  (t/assert-equal "one" (sol/say 1)))

(t/deftest "fourteen"
  (t/assert-equal "fourteen" (sol/say 14)))

(t/deftest "twenty"
  (t/assert-equal "twenty" (sol/say 20)))

(t/deftest "twenty-two"
  (t/assert-equal "twenty-two" (sol/say 22)))

(t/deftest "thirty"
  (t/assert-equal "thirty" (sol/say 30)))

(t/deftest "ninety-nine"
  (t/assert-equal "ninety-nine" (sol/say 99)))

(t/deftest "one hundred"
  (t/assert-equal "one hundred" (sol/say 100)))

(t/deftest "one hundred twenty-three"
  (t/assert-equal "one hundred twenty-three" (sol/say 123)))

(t/deftest "two hundred"
  (t/assert-equal "two hundred" (sol/say 200)))

(t/deftest "nine hundred ninety-nine"
  (t/assert-equal "nine hundred ninety-nine" (sol/say 999)))

(t/deftest "one thousand"
  (t/assert-equal "one thousand" (sol/say 1000)))

(t/deftest "one thousand two hundred thirty-four"
  (t/assert-equal "one thousand two hundred thirty-four" (sol/say 1234)))

(t/deftest "one million"
  (t/assert-equal "one million" (sol/say 1000000)))

(t/deftest "one million two thousand three hundred forty-five"
  (t/assert-equal "one million two thousand three hundred forty-five" (sol/say 1002345)))

(t/deftest "one billion"
  (t/assert-equal "one billion" (sol/say 1000000000)))

(t/deftest "a big number"
  (t/assert-equal "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three" (sol/say 987654321123)))

(t/deftest "numbers below zero are out of range"
  (t/assert-error "input out of range" (sol/say -1)))

(t/deftest "numbers above 999,999,999,999 are out of range"
  (t/assert-error "input out of range" (sol/say 1000000000000)))

(t/run)
