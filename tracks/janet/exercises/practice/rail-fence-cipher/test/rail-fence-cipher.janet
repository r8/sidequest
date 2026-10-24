(import test :as t)
(import ../rail-fence-cipher :as sol)

(t/deftest "encode with two rails"
  (t/assert-equal "XXXXXXXXXOOOOOOOOO" (sol/encode "XOXOXOXOXOXOXOXOXO" 2)))

(t/deftest "encode with three rails"
  (t/assert-equal "WECRLTEERDSOEEFEAOCAIVDEN" (sol/encode "WEAREDISCOVEREDFLEEATONCE" 3)))

(t/deftest "encode with ending in the middle"
  (t/assert-equal "ESXIEECSR" (sol/encode "EXERCISES" 4)))

# Not in the canonical data: one rail never zig-zags, so the text reads straight through.
(t/deftest "encode with one rail"
  (t/assert-equal "ABCDE" (sol/encode "ABCDE" 1)))

(t/deftest "decode with three rails"
  (t/assert-equal "THEDEVILISINTHEDETAILS" (sol/decode "TEITELHDVLSNHDTISEIIEA" 3)))

(t/deftest "decode with five rails"
  (t/assert-equal "EXERCISMISAWESOME" (sol/decode "EIEXMSMESAORIWSCE" 5)))

(t/deftest "decode with six rails"
  (t/assert-equal "112358132134558914423337761098715972584418167651094617711286" (sol/decode "133714114238148966225439541018335470986172518171757571896261" 6)))

# Not in the canonical data: one rail never zig-zags, so the text reads straight through.
(t/deftest "decode with one rail"
  (t/assert-equal "ABCDE" (sol/decode "ABCDE" 1)))

(t/run)
