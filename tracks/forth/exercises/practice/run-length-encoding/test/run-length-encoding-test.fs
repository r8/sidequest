require ../lib/test.fs
require ../run-length-encoding.fs

test" run-length encode a string > empty string"  0 0 encode s" " assert-str= ;test
test" run-length encode a string > single characters only are encoded without count"  s" XYZ" encode s" XYZ" assert-str= ;test
test" run-length encode a string > string with no single characters"  s" AABBBCCCC" encode s" 2A3B4C" assert-str= ;test
test" run-length encode a string > single characters mixed with repeated characters"
  s" WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" encode
  s" 12WB12W3B24WB" assert-str= ;test
test" run-length encode a string > multiple whitespace mixed in string"  s"   hsqq qww  " encode s" 2 hs2q q2w2 " assert-str= ;test
test" run-length encode a string > lowercase characters"  s" aabbbcccc" encode s" 2a3b4c" assert-str= ;test
test" run-length decode a string > empty string"  0 0 decode s" " assert-str= ;test
test" run-length decode a string > single characters only"  s" XYZ" decode s" XYZ" assert-str= ;test
test" run-length decode a string > string with no single characters"  s" 2A3B4C" decode s" AABBBCCCC" assert-str= ;test
test" run-length decode a string > single characters with repeated characters"
  s" 12WB12W3B24WB" decode
  s" WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" assert-str= ;test
test" run-length decode a string > multiple whitespace mixed in string"  s" 2 hs2q q2w2 " decode s"   hsqq qww  " assert-str= ;test
test" run-length decode a string > lowercase string"  s" 2a3b4c" decode s" aabbbcccc" assert-str= ;test
test" encode and then decode > encode followed by decode gives original string"
  s" zzz ZZ  zZ" encode decode s" zzz ZZ  zZ" assert-str= ;test

\ Not in the canonical data: runs and strings longer than any fixed-size buffer a solution might
\ reach for.
create long-run 3000 chars allot  long-run 3000 char a fill
test" decode a long run"  s" 3000a" decode long-run 3000 assert-str= ;test
create no-runs 3000 chars allot
: fill-no-runs ( -- ) 3000 0 do  s" ab" no-runs i chars + swap chars move  2 +loop ;  fill-no-runs
test" encode a long string without runs"  no-runs 3000 encode no-runs 3000 assert-str= ;test

end-tests
