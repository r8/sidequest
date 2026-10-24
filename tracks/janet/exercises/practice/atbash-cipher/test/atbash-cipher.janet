(import test :as t)
(import ../atbash-cipher :as sol)

(t/deftest "encode yes"
  (t/assert-equal "bvh" (sol/encode "yes")))

(t/deftest "encode no"
  (t/assert-equal "ml" (sol/encode "no")))

(t/deftest "encode OMG"
  (t/assert-equal "lnt" (sol/encode "OMG")))

(t/deftest "encode spaces"
  (t/assert-equal "lnt" (sol/encode "O M G")))

(t/deftest "encode mindblowingly"
  (t/assert-equal "nrmwy oldrm tob" (sol/encode "mindblowingly")))

(t/deftest "encode numbers"
  (t/assert-equal "gvhgr mt123 gvhgr mt" (sol/encode "Testing,1 2 3, testing.")))

(t/deftest "encode deep thought"
  (t/assert-equal "gifgs rhurx grlm" (sol/encode "Truth is fiction.")))

(t/deftest "encode all the letters"
  (t/assert-equal "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt" (sol/encode "The quick brown fox jumps over the lazy dog.")))

(t/deftest "decode exercism"
  (t/assert-equal "exercism" (sol/decode "vcvix rhn")))

(t/deftest "decode a sentence"
  (t/assert-equal "anobstacleisoftenasteppingstone" (sol/decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v")))

(t/deftest "decode numbers"
  (t/assert-equal "testing123testing" (sol/decode "gvhgr mt123 gvhgr mt")))

(t/deftest "decode all the letters"
  (t/assert-equal "thequickbrownfoxjumpsoverthelazydog" (sol/decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")))

(t/deftest "decode with too many spaces"
  (t/assert-equal "exercism" (sol/decode "vc vix    r hn")))

(t/deftest "decode with no spaces"
  (t/assert-equal "anobstacleisoftenasteppingstone" (sol/decode "zmlyhgzxovrhlugvmzhgvkkrmthglmv")))

(t/run)
