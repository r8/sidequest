(import test :as t)
(import ../affine-cipher :as sol)

(t/deftest "encode yes"
  (t/assert-equal "xbt" (sol/encode "yes" 5 7)))

(t/deftest "encode no"
  (t/assert-equal "fu" (sol/encode "no" 15 18)))

(t/deftest "encode OMG"
  (t/assert-equal "lvz" (sol/encode "OMG" 21 3)))

(t/deftest "encode O M G"
  (t/assert-equal "hjp" (sol/encode "O M G" 25 47)))

(t/deftest "encode mindblowingly"
  (t/assert-equal "rzcwa gnxzc dgt" (sol/encode "mindblowingly" 11 15)))

(t/deftest "encode numbers"
  (t/assert-equal "jqgjc rw123 jqgjc rw" (sol/encode "Testing,1 2 3, testing." 3 4)))

(t/deftest "encode deep thought"
  (t/assert-equal "iynia fdqfb ifje" (sol/encode "Truth is fiction." 5 17)))

(t/deftest "encode all the letters"
  (t/assert-equal "swxtj npvyk lruol iejdc blaxk swxmh qzglf" (sol/encode "The quick brown fox jumps over the lazy dog." 17 33)))

(t/deftest "encode with a not coprime to m"
  (t/assert-error "a and m must be coprime." (sol/encode "This is a test." 6 17)))

(t/deftest "decode exercism"
  (t/assert-equal "exercism" (sol/decode "tytgn fjr" 3 7)))

(t/deftest "decode a sentence"
  (t/assert-equal "anobstacleisoftenasteppingstone" (sol/decode "qdwju nqcro muwhn odqun oppmd aunwd o" 19 16)))

(t/deftest "decode numbers"
  (t/assert-equal "testing123testing" (sol/decode "odpoz ub123 odpoz ub" 25 7)))

(t/deftest "decode all the letters"
  (t/assert-equal "thequickbrownfoxjumpsoverthelazydog" (sol/decode "swxtj npvyk lruol iejdc blaxk swxmh qzglf" 17 33)))

(t/deftest "decode with no spaces in input"
  (t/assert-equal "thequickbrownfoxjumpsoverthelazydog" (sol/decode "swxtjnpvyklruoliejdcblaxkswxmhqzglf" 17 33)))

(t/deftest "decode with too many spaces"
  (t/assert-equal "jollygreengiant" (sol/decode "vszzm    cly   yd cg    qdp" 15 16)))

(t/deftest "decode with a not coprime to m"
  (t/assert-error "a and m must be coprime." (sol/decode "Test" 13 5)))

(t/run)
