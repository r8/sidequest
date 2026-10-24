(import test :as t)
(import ../run-length-encoding :as sol)

(t/deftest "empty string"
  (t/assert-equal "" (sol/encode "")))

(t/deftest "single characters only are encoded without count"
  (t/assert-equal "XYZ" (sol/encode "XYZ")))

(t/deftest "string with no single characters"
  (t/assert-equal "2A3B4C" (sol/encode "AABBBCCCC")))

(t/deftest "single characters mixed with repeated characters"
  (t/assert-equal "12WB12W3B24WB" (sol/encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")))

(t/deftest "multiple whitespace mixed in string"
  (t/assert-equal "2 hs2q q2w2 " (sol/encode "  hsqq qww  ")))

(t/deftest "lowercase characters"
  (t/assert-equal "2a3b4c" (sol/encode "aabbbcccc")))

(t/deftest "run-length decode a string > empty string"
  (t/assert-equal "" (sol/decode "")))

(t/deftest "single characters only"
  (t/assert-equal "XYZ" (sol/decode "XYZ")))

(t/deftest "run-length decode a string > string with no single characters"
  (t/assert-equal "AABBBCCCC" (sol/decode "2A3B4C")))

(t/deftest "single characters with repeated characters"
  (t/assert-equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" (sol/decode "12WB12W3B24WB")))

(t/deftest "run-length decode a string > multiple whitespace mixed in string"
  (t/assert-equal "  hsqq qww  " (sol/decode "2 hs2q q2w2 ")))

(t/deftest "lowercase string"
  (t/assert-equal "aabbbcccc" (sol/decode "2a3b4c")))

(t/deftest "encode followed by decode gives original string"
  (t/assert-equal "zzz ZZ  zZ" (sol/decode (sol/encode "zzz ZZ  zZ"))))

(t/run)
