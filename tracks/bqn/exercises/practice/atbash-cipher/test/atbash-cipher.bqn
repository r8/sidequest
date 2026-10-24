t ← •Import "../lib/test.bqn"
g ← •Import "../atbash-cipher.bqn"

t.Run ⟨
  "encode > encode yes"‿{𝕊: "bvh" t.Expect g.Encode "yes"}
  "encode > encode no"‿{𝕊: "ml" t.Expect g.Encode "no"}
  "encode > encode OMG"‿{𝕊: "lnt" t.Expect g.Encode "OMG"}
  "encode > encode spaces"‿{𝕊: "lnt" t.Expect g.Encode "O M G"}
  "encode > encode mindblowingly"‿{𝕊: "nrmwy oldrm tob" t.Expect g.Encode "mindblowingly"}
  "encode > encode numbers"‿{𝕊: "gvhgr mt123 gvhgr mt" t.Expect g.Encode "Testing,1 2 3, testing."}
  "encode > encode deep thought"‿{𝕊: "gifgs rhurx grlm" t.Expect g.Encode "Truth is fiction."}
  "encode > encode all the letters"‿{𝕊: "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt" t.Expect g.Encode "The quick brown fox jumps over the lazy dog."}
  "decode > decode exercism"‿{𝕊: "exercism" t.Expect g.Decode "vcvix rhn"}
  "decode > decode a sentence"‿{𝕊: "anobstacleisoftenasteppingstone" t.Expect g.Decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v"}
  "decode > decode numbers"‿{𝕊: "testing123testing" t.Expect g.Decode "gvhgr mt123 gvhgr mt"}
  "decode > decode all the letters"‿{𝕊: "thequickbrownfoxjumpsoverthelazydog" t.Expect g.Decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"}
  "decode > decode with too many spaces"‿{𝕊: "exercism" t.Expect g.Decode "vc vix    r hn"}
  "decode > decode with no spaces"‿{𝕊: "anobstacleisoftenasteppingstone" t.Expect g.Decode "zmlyhgzxovrhlugvmzhgvkkrmthglmv"}
⟩
