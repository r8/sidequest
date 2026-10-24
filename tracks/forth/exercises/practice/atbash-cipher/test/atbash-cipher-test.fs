require ../lib/test.fs
require ../atbash-cipher.fs

test" encode > encode yes"  s" yes" encode s" bvh" assert-str= ;test
test" encode > encode no"  s" no" encode s" ml" assert-str= ;test
test" encode > encode OMG"  s" OMG" encode s" lnt" assert-str= ;test
test" encode > encode spaces"  s" O M G" encode s" lnt" assert-str= ;test
test" encode > encode mindblowingly"  s" mindblowingly" encode s" nrmwy oldrm tob" assert-str= ;test
test" encode > encode numbers"
  s" Testing,1 2 3, testing." encode s" gvhgr mt123 gvhgr mt" assert-str= ;test
test" encode > encode deep thought"  s" Truth is fiction." encode s" gifgs rhurx grlm" assert-str= ;test
test" encode > encode all the letters"
  s" The quick brown fox jumps over the lazy dog." encode
  s" gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt" assert-str= ;test
test" decode > decode exercism"  s" vcvix rhn" decode s" exercism" assert-str= ;test
test" decode > decode a sentence"
  s" zmlyh gzxov rhlug vmzhg vkkrm thglm v" decode
  s" anobstacleisoftenasteppingstone" assert-str= ;test
test" decode > decode numbers"  s" gvhgr mt123 gvhgr mt" decode s" testing123testing" assert-str= ;test
test" decode > decode all the letters"
  s" gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt" decode
  s" thequickbrownfoxjumpsoverthelazydog" assert-str= ;test
test" decode > decode with too many spaces"  s" vc vix    r hn" decode s" exercism" assert-str= ;test
test" decode > decode with no spaces"
  s" zmlyhgzxovrhlugvmzhgvkkrmthglmv" decode
  s" anobstacleisoftenasteppingstone" assert-str= ;test

\ Not in the canonical data: a text longer than any fixed-size buffer a solution might reach for.
create long-plain 1000 chars allot  long-plain 1000 char a fill
create long-cipher 1199 chars allot  long-cipher 1199 char z fill
: space-groups ( -- ) 1199 5 do  bl long-cipher i chars + c!  6 +loop ;  space-groups
test" encode a long text"  long-plain 1000 encode long-cipher 1199 assert-str= ;test
test" decode a long text"  long-cipher 1199 decode long-plain 1000 assert-str= ;test

end-tests
