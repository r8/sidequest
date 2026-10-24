t ← •Import "../lib/test.bqn"
g ← •Import "../rail-fence-cipher.bqn"

t.Run ⟨
  "encode > encode with two rails"‿{𝕊: "XXXXXXXXXOOOOOOOOO" t.Expect 2 g.Encode "XOXOXOXOXOXOXOXOXO"}
  "encode > encode with three rails"‿{𝕊: "WECRLTEERDSOEEFEAOCAIVDEN" t.Expect 3 g.Encode "WEAREDISCOVEREDFLEEATONCE"}
  "encode > encode with ending in the middle"‿{𝕊: "ESXIEECSR" t.Expect 4 g.Encode "EXERCISES"}
  "decode > decode with three rails"‿{𝕊: "THEDEVILISINTHEDETAILS" t.Expect 3 g.Decode "TEITELHDVLSNHDTISEIIEA"}
  "decode > decode with five rails"‿{𝕊: "EXERCISMISAWESOME" t.Expect 5 g.Decode "EIEXMSMESAORIWSCE"}
  "decode > decode with six rails"‿{𝕊:
    "112358132134558914423337761098715972584418167651094617711286" t.Expect 6 g.Decode "133714114238148966225439541018335470986172518171757571896261"
  }
  # Not in the canonical data: one rail never zig-zags, so the text reads straight through.
  "encode > encode with one rail"‿{𝕊: "ABCDE" t.Expect 1 g.Encode "ABCDE"}
  "decode > decode with one rail"‿{𝕊: "ABCDE" t.Expect 1 g.Decode "ABCDE"}
⟩
