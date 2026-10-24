t ← •Import "../lib/test.bqn"
g ← •Import "../affine-cipher.bqn"

t.Run ⟨
  "encode > encode yes"‿{𝕊: "xbt" t.Expect 5‿7 g.Encode "yes"}
  "encode > encode no"‿{𝕊: "fu" t.Expect 15‿18 g.Encode "no"}
  "encode > encode OMG"‿{𝕊: "lvz" t.Expect 21‿3 g.Encode "OMG"}
  "encode > encode O M G"‿{𝕊: "hjp" t.Expect 25‿47 g.Encode "O M G"}
  "encode > encode mindblowingly"‿{𝕊: "rzcwa gnxzc dgt" t.Expect 11‿15 g.Encode "mindblowingly"}
  "encode > encode numbers"‿{𝕊: "jqgjc rw123 jqgjc rw" t.Expect 3‿4 g.Encode "Testing,1 2 3, testing."}
  "encode > encode deep thought"‿{𝕊: "iynia fdqfb ifje" t.Expect 5‿17 g.Encode "Truth is fiction."}
  "encode > encode all the letters"‿{𝕊: "swxtj npvyk lruol iejdc blaxk swxmh qzglf" t.Expect 17‿33 g.Encode "The quick brown fox jumps over the lazy dog."}
  "encode > encode with a not coprime to m"‿{𝕊: {𝕊: 6‿17 g.Encode "This is a test."} t._throws "a and m must be coprime."}
  "decode > decode exercism"‿{𝕊: "exercism" t.Expect 3‿7 g.Decode "tytgn fjr"}
  "decode > decode a sentence"‿{𝕊: "anobstacleisoftenasteppingstone" t.Expect 19‿16 g.Decode "qdwju nqcro muwhn odqun oppmd aunwd o"}
  "decode > decode numbers"‿{𝕊: "testing123testing" t.Expect 25‿7 g.Decode "odpoz ub123 odpoz ub"}
  "decode > decode all the letters"‿{𝕊: "thequickbrownfoxjumpsoverthelazydog" t.Expect 17‿33 g.Decode "swxtj npvyk lruol iejdc blaxk swxmh qzglf"}
  "decode > decode with no spaces in input"‿{𝕊: "thequickbrownfoxjumpsoverthelazydog" t.Expect 17‿33 g.Decode "swxtjnpvyklruoliejdcblaxkswxmhqzglf"}
  "decode > decode with too many spaces"‿{𝕊: "jollygreengiant" t.Expect 15‿16 g.Decode "vszzm    cly   yd cg    qdp"}
  "decode > decode with a not coprime to m"‿{𝕊: {𝕊: 13‿5 g.Decode "Test"} t._throws "a and m must be coprime."}
⟩
