require ../lib/test.fs
require ../largest-series-product.fs

test" finds the largest product if span equals length"  s" 29" 2 largest-product 18 assert= ;test
test" can find the largest product of 2 with numbers in order"  s" 0123456789" 2 largest-product 72 assert= ;test
test" can find the largest product of 2"  s" 576802143" 2 largest-product 48 assert= ;test
test" can find the largest product of 3 with numbers in order"  s" 0123456789" 3 largest-product 504 assert= ;test
test" can find the largest product of 3"  s" 1027839564" 3 largest-product 270 assert= ;test
test" can find the largest product of 5 with numbers in order"  s" 0123456789" 5 largest-product 15120 assert= ;test
test" can get the largest product of a big number"
  s" 73167176531330624919225119674426574742355349194934" 6 largest-product 23520 assert= ;test
test" reports zero if the only digits are zero"  s" 0000" 2 largest-product 0 assert= ;test
test" reports zero if all spans include zero"  s" 99099" 3 largest-product 0 assert= ;test

: span-too-long ( -- n ) s" 123" 4 largest-product ;
test" rejects span longer than string length"  ['] span-too-long -24 assert-xt-throws ;test

test" reports 1 for empty string and empty product (0 span)"  s" " 0 largest-product 1 assert= ;test
test" reports 1 for nonempty string and empty product (0 span)"  s" 123" 0 largest-product 1 assert= ;test

: empty-nonzero-span ( -- n ) s" " 1 largest-product ;
test" rejects empty string and nonzero span"  ['] empty-nonzero-span -24 assert-xt-throws ;test

: invalid-digit ( -- n ) s" 1234a5" 2 largest-product ;
test" rejects invalid character in digits"  ['] invalid-digit -24 assert-xt-throws ;test

: negative-span ( -- n ) s" 12345" -1 largest-product ;
test" rejects negative span"  ['] negative-span -24 assert-xt-throws ;test

end-tests
