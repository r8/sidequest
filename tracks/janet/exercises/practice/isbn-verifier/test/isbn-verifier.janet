(import test :as t)
(import ../isbn-verifier :as sol)

(t/deftest "valid isbn"
  (t/assert-true (sol/valid? "3-598-21508-8")))

(t/deftest "invalid isbn check digit"
  (t/assert-false (sol/valid? "3-598-21508-9")))

(t/deftest "valid isbn with a check digit of 10"
  (t/assert-true (sol/valid? "3-598-21507-X")))

(t/deftest "check digit is a character other than X"
  (t/assert-false (sol/valid? "3-598-21507-A")))

(t/deftest "invalid check digit in isbn is not treated as zero"
  (t/assert-false (sol/valid? "4-598-21507-B")))

(t/deftest "invalid character in isbn is not treated as zero"
  (t/assert-false (sol/valid? "3-598-P1581-X")))

(t/deftest "X is only valid as a check digit"
  (t/assert-false (sol/valid? "3-598-2X507-9")))

(t/deftest "only one check digit is allowed"
  (t/assert-false (sol/valid? "3-598-21508-96")))

(t/deftest "X is not substituted by the value 10"
  (t/assert-false (sol/valid? "3-598-2X507-5")))

(t/deftest "valid isbn without separating dashes"
  (t/assert-true (sol/valid? "3598215088")))

(t/deftest "isbn without separating dashes and X as check digit"
  (t/assert-true (sol/valid? "359821507X")))

(t/deftest "isbn without check digit and dashes"
  (t/assert-false (sol/valid? "359821507")))

(t/deftest "too long isbn and no dashes"
  (t/assert-false (sol/valid? "3598215078X")))

(t/deftest "too short isbn"
  (t/assert-false (sol/valid? "00")))

(t/deftest "isbn without check digit"
  (t/assert-false (sol/valid? "3-598-21507")))

(t/deftest "check digit of X should not be used for 0"
  (t/assert-false (sol/valid? "3-598-21515-X")))

(t/deftest "empty isbn"
  (t/assert-false (sol/valid? "")))

(t/deftest "input is 9 characters"
  (t/assert-false (sol/valid? "134456729")))

(t/deftest "invalid characters are not ignored after checking length"
  (t/assert-false (sol/valid? "3132P34035")))

(t/deftest "invalid characters are not ignored before checking length"
  (t/assert-false (sol/valid? "3598P215088")))

(t/deftest "input is too long but contains a valid isbn"
  (t/assert-false (sol/valid? "98245726788")))

(t/run)
