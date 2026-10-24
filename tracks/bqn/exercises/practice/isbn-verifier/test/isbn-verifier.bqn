t ← •Import "../lib/test.bqn"
g ← •Import "../isbn-verifier.bqn"

t.Run ⟨
  "valid isbn"‿{𝕊: 1 t.Expect g.IsValid "3-598-21508-8"}
  "invalid isbn check digit"‿{𝕊: 0 t.Expect g.IsValid "3-598-21508-9"}
  "valid isbn with a check digit of 10"‿{𝕊: 1 t.Expect g.IsValid "3-598-21507-X"}
  "check digit is a character other than X"‿{𝕊: 0 t.Expect g.IsValid "3-598-21507-A"}
  "invalid check digit in isbn is not treated as zero"‿{𝕊: 0 t.Expect g.IsValid "4-598-21507-B"}
  "invalid character in isbn is not treated as zero"‿{𝕊: 0 t.Expect g.IsValid "3-598-P1581-X"}
  "X is only valid as a check digit"‿{𝕊: 0 t.Expect g.IsValid "3-598-2X507-9"}
  "only one check digit is allowed"‿{𝕊: 0 t.Expect g.IsValid "3-598-21508-96"}
  "X is not substituted by the value 10"‿{𝕊: 0 t.Expect g.IsValid "3-598-2X507-5"}
  "valid isbn without separating dashes"‿{𝕊: 1 t.Expect g.IsValid "3598215088"}
  "isbn without separating dashes and X as check digit"‿{𝕊: 1 t.Expect g.IsValid "359821507X"}
  "isbn without check digit and dashes"‿{𝕊: 0 t.Expect g.IsValid "359821507"}
  "too long isbn and no dashes"‿{𝕊: 0 t.Expect g.IsValid "3598215078X"}
  "too short isbn"‿{𝕊: 0 t.Expect g.IsValid "00"}
  "isbn without check digit"‿{𝕊: 0 t.Expect g.IsValid "3-598-21507"}
  "check digit of X should not be used for 0"‿{𝕊: 0 t.Expect g.IsValid "3-598-21515-X"}
  "empty isbn"‿{𝕊: 0 t.Expect g.IsValid ""}
  "input is 9 characters"‿{𝕊: 0 t.Expect g.IsValid "134456729"}
  "invalid characters are not ignored after checking length"‿{𝕊: 0 t.Expect g.IsValid "3132P34035"}
  "invalid characters are not ignored before checking length"‿{𝕊: 0 t.Expect g.IsValid "3598P215088"}
  "input is too long but contains a valid isbn"‿{𝕊: 0 t.Expect g.IsValid "98245726788"}
⟩
