t ← •Import "../lib/test.bqn"
g ← •Import "../isogram.bqn"

t.Run ⟨
  "empty string"‿{𝕊: 1 t.Expect g.IsIsogram ""}
  "isogram with only lower case characters"‿{𝕊: 1 t.Expect g.IsIsogram "isogram"}
  "word with one duplicated character"‿{𝕊: 0 t.Expect g.IsIsogram "eleven"}
  "word with one duplicated character from the end of the alphabet"‿{𝕊: 0 t.Expect g.IsIsogram "zzyzx"}
  "longest reported english isogram"‿{𝕊: 1 t.Expect g.IsIsogram "subdermatoglyphic"}
  "word with duplicated character in mixed case"‿{𝕊: 0 t.Expect g.IsIsogram "Alphabet"}
  "word with duplicated character in mixed case, lowercase first"‿{𝕊: 0 t.Expect g.IsIsogram "alphAbet"}
  "hypothetical isogrammic word with hyphen"‿{𝕊: 1 t.Expect g.IsIsogram "thumbscrew-japingly"}
  "hypothetical word with duplicated character following hyphen"‿{𝕊: 0 t.Expect g.IsIsogram "thumbscrew-jappingly"}
  "isogram with duplicated hyphen"‿{𝕊: 1 t.Expect g.IsIsogram "six-year-old"}
  "made-up name that is an isogram"‿{𝕊: 1 t.Expect g.IsIsogram "Emily Jung Schwartzkopf"}
  "duplicated character in the middle"‿{𝕊: 0 t.Expect g.IsIsogram "accentor"}
  "same first and last characters"‿{𝕊: 0 t.Expect g.IsIsogram "angola"}
  "word with duplicated character and with two hyphens"‿{𝕊: 0 t.Expect g.IsIsogram "up-to-date"}
  # Not in the canonical data: letters beyond ASCII, in either case.
  "repeated letter beyond ASCII"‿{𝕊: 0 t.Expect g.IsIsogram "élégant"}
  "repeated letter beyond ASCII in mixed case"‿{𝕊: 0 t.Expect g.IsIsogram "Ёлка ёж"}
⟩
