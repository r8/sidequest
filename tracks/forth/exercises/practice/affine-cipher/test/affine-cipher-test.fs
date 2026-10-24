require ../lib/test.fs
require ../affine-cipher.fs

test" encode > encode yes"  s" yes" 5 7 encode s" xbt" assert-str= ;test
test" encode > encode no"  s" no" 15 18 encode s" fu" assert-str= ;test
test" encode > encode OMG"  s" OMG" 21 3 encode s" lvz" assert-str= ;test
test" encode > encode O M G"  s" O M G" 25 47 encode s" hjp" assert-str= ;test
test" encode > encode mindblowingly"  s" mindblowingly" 11 15 encode s" rzcwa gnxzc dgt" assert-str= ;test
test" encode > encode numbers"
  s" Testing,1 2 3, testing." 3 4 encode s" jqgjc rw123 jqgjc rw" assert-str= ;test
test" encode > encode deep thought"  s" Truth is fiction." 5 17 encode s" iynia fdqfb ifje" assert-str= ;test
test" encode > encode all the letters"
  s" The quick brown fox jumps over the lazy dog." 17 33 encode
  s" swxtj npvyk lruol iejdc blaxk swxmh qzglf" assert-str= ;test

: encode-not-coprime ( -- c-addr u ) s" This is a test." 6 17 encode ;
test" encode > encode with a not coprime to m"  ['] encode-not-coprime -24 assert-xt-throws ;test

test" decode > decode exercism"  s" tytgn fjr" 3 7 decode s" exercism" assert-str= ;test
test" decode > decode a sentence"
  s" qdwju nqcro muwhn odqun oppmd aunwd o" 19 16 decode
  s" anobstacleisoftenasteppingstone" assert-str= ;test
test" decode > decode numbers"  s" odpoz ub123 odpoz ub" 25 7 decode s" testing123testing" assert-str= ;test
test" decode > decode all the letters"
  s" swxtj npvyk lruol iejdc blaxk swxmh qzglf" 17 33 decode
  s" thequickbrownfoxjumpsoverthelazydog" assert-str= ;test
test" decode > decode with no spaces in input"
  s" swxtjnpvyklruoliejdcblaxkswxmhqzglf" 17 33 decode
  s" thequickbrownfoxjumpsoverthelazydog" assert-str= ;test
test" decode > decode with too many spaces"
  s" vszzm    cly   yd cg    qdp" 15 16 decode s" jollygreengiant" assert-str= ;test

: decode-not-coprime ( -- c-addr u ) s" Test" 13 5 decode ;
test" decode > decode with a not coprime to m"  ['] decode-not-coprime -24 assert-xt-throws ;test

\ Not in the canonical data: a text longer than any fixed-size buffer a solution might reach for.
create long-plain 1000 chars allot  long-plain 1000 char a fill
create long-cipher 1199 chars allot  long-cipher 1199 char h fill
: space-groups ( -- ) 1199 5 do  bl long-cipher i chars + c!  6 +loop ;  space-groups
test" encode a long text"  long-plain 1000 5 7 encode long-cipher 1199 assert-str= ;test
test" decode a long text"  long-cipher 1199 5 7 decode long-plain 1000 assert-str= ;test

end-tests
