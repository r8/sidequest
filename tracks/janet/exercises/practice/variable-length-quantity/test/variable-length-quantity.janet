(import test :as t)
(import ../variable-length-quantity :as sol)

(t/deftest "zero"
  (t/assert-equal [0] (sol/encode [0])))

(t/deftest "arbitrary single byte"
  (t/assert-equal [64] (sol/encode [64])))

(t/deftest "asymmetric single byte"
  (t/assert-equal [83] (sol/encode [83])))

(t/deftest "largest single byte"
  (t/assert-equal [127] (sol/encode [127])))

(t/deftest "smallest double byte"
  (t/assert-equal [129 0] (sol/encode [128])))

(t/deftest "arbitrary double byte"
  (t/assert-equal [192 0] (sol/encode [8192])))

(t/deftest "asymmetric double byte"
  (t/assert-equal [129 45] (sol/encode [173])))

(t/deftest "largest double byte"
  (t/assert-equal [255 127] (sol/encode [16383])))

(t/deftest "smallest triple byte"
  (t/assert-equal [129 128 0] (sol/encode [16384])))

(t/deftest "arbitrary triple byte"
  (t/assert-equal [192 128 0] (sol/encode [1048576])))

(t/deftest "asymmetric triple byte"
  (t/assert-equal [135 171 28] (sol/encode [120220])))

(t/deftest "largest triple byte"
  (t/assert-equal [255 255 127] (sol/encode [2097151])))

(t/deftest "smallest quadruple byte"
  (t/assert-equal [129 128 128 0] (sol/encode [2097152])))

(t/deftest "arbitrary quadruple byte"
  (t/assert-equal [192 128 128 0] (sol/encode [134217728])))

(t/deftest "asymmetric quadruple byte"
  (t/assert-equal [129 213 238 4] (sol/encode [3503876])))

(t/deftest "largest quadruple byte"
  (t/assert-equal [255 255 255 127] (sol/encode [268435455])))

(t/deftest "smallest quintuple byte"
  (t/assert-equal [129 128 128 128 0] (sol/encode [268435456])))

(t/deftest "arbitrary quintuple byte"
  (t/assert-equal [143 248 128 128 0] (sol/encode [4278190080])))

(t/deftest "asymmetric quintuple byte"
  (t/assert-equal [136 179 149 194 5] (sol/encode [2254790917])))

(t/deftest "maximum 32-bit integer input"
  (t/assert-equal [143 255 255 255 127] (sol/encode [4294967295])))

(t/deftest "two single-byte values"
  (t/assert-equal [64 127] (sol/encode [64 127])))

(t/deftest "two multi-byte values"
  (t/assert-equal [129 128 0 200 232 86] (sol/encode [16384 1193046])))

(t/deftest "many multi-byte values"
  (t/assert-equal [192 0 200 232 86 255 255 255 127 0 255 127 129 128 0] (sol/encode [8192 1193046 268435455 0 16383 16384])))

(t/deftest "one byte"
  (t/assert-equal [127] (sol/decode [127])))

(t/deftest "two bytes"
  (t/assert-equal [8192] (sol/decode [192 0])))

(t/deftest "three bytes"
  (t/assert-equal [2097151] (sol/decode [255 255 127])))

(t/deftest "four bytes"
  (t/assert-equal [2097152] (sol/decode [129 128 128 0])))

(t/deftest "maximum 32-bit integer"
  (t/assert-equal [4294967295] (sol/decode [143 255 255 255 127])))

(t/deftest "incomplete sequence causes error"
  (t/assert-error "incomplete sequence" (sol/decode [255])))

(t/deftest "incomplete sequence causes error, even if value is zero"
  (t/assert-error "incomplete sequence" (sol/decode [128])))

(t/deftest "multiple values"
  (t/assert-equal [8192 1193046 268435455 0 16383 16384] (sol/decode [192 0 200 232 86 255 255 255 127 0 255 127 129 128 0])))

(t/run)
