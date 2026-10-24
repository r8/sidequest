t ← •Import "../lib/test.bqn"
g ← •Import "../run-length-encoding.bqn"

t.Run ⟨
  "run-length encode a string > empty string"‿{𝕊: "" t.Expect g.Encode ""}
  "run-length encode a string > single characters only are encoded without count"‿{𝕊: "XYZ" t.Expect g.Encode "XYZ"}
  "run-length encode a string > string with no single characters"‿{𝕊: "2A3B4C" t.Expect g.Encode "AABBBCCCC"}
  "run-length encode a string > single characters mixed with repeated characters"‿{𝕊: "12WB12W3B24WB" t.Expect g.Encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"}
  "run-length encode a string > multiple whitespace mixed in string"‿{𝕊: "2 hs2q q2w2 " t.Expect g.Encode "  hsqq qww  "}
  "run-length encode a string > lowercase characters"‿{𝕊: "2a3b4c" t.Expect g.Encode "aabbbcccc"}
  "run-length decode a string > empty string"‿{𝕊: "" t.Expect g.Decode ""}
  "run-length decode a string > single characters only"‿{𝕊: "XYZ" t.Expect g.Decode "XYZ"}
  "run-length decode a string > string with no single characters"‿{𝕊: "AABBBCCCC" t.Expect g.Decode "2A3B4C"}
  "run-length decode a string > single characters with repeated characters"‿{𝕊: "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" t.Expect g.Decode "12WB12W3B24WB"}
  "run-length decode a string > multiple whitespace mixed in string"‿{𝕊: "  hsqq qww  " t.Expect g.Decode "2 hs2q q2w2 "}
  "run-length decode a string > lowercase string"‿{𝕊: "aabbbcccc" t.Expect g.Decode "2a3b4c"}
  "encode and then decode > encode followed by decode gives original string"‿{𝕊: "zzz ZZ  zZ" t.Expect g.Decode g.Encode "zzz ZZ  zZ"}
⟩
