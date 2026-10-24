(import test :as t)
(import ../largest-series-product :as sol)

(t/deftest "finds the largest product if span equals length"
  (t/assert-equal 18 (sol/largest-product "29" 2)))

(t/deftest "can find the largest product of 2 with numbers in order"
  (t/assert-equal 72 (sol/largest-product "0123456789" 2)))

(t/deftest "can find the largest product of 2"
  (t/assert-equal 48 (sol/largest-product "576802143" 2)))

(t/deftest "can find the largest product of 3 with numbers in order"
  (t/assert-equal 504 (sol/largest-product "0123456789" 3)))

(t/deftest "can find the largest product of 3"
  (t/assert-equal 270 (sol/largest-product "1027839564" 3)))

(t/deftest "can find the largest product of 5 with numbers in order"
  (t/assert-equal 15120 (sol/largest-product "0123456789" 5)))

(t/deftest "can get the largest product of a big number"
  (t/assert-equal 23520 (sol/largest-product "73167176531330624919225119674426574742355349194934" 6)))

(t/deftest "reports zero if the only digits are zero"
  (t/assert-equal 0 (sol/largest-product "0000" 2)))

(t/deftest "reports zero if all spans include zero"
  (t/assert-equal 0 (sol/largest-product "99099" 3)))

(t/deftest "rejects span longer than string length"
  (t/assert-error "span must not exceed string length" (sol/largest-product "123" 4)))

(t/deftest "reports 1 for empty string and empty product (0 span)"
  (t/assert-equal 1 (sol/largest-product "" 0)))

(t/deftest "reports 1 for nonempty string and empty product (0 span)"
  (t/assert-equal 1 (sol/largest-product "123" 0)))

(t/deftest "rejects empty string and nonzero span"
  (t/assert-error "span must not exceed string length" (sol/largest-product "" 1)))

(t/deftest "rejects invalid character in digits"
  (t/assert-error "digits input must only contain digits" (sol/largest-product "1234a5" 2)))

(t/deftest "rejects negative span"
  (t/assert-error "span must not be negative" (sol/largest-product "12345" -1)))

(t/run)
