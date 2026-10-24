t ← •Import "../lib/test.bqn"
g ← •Import "../rotational-cipher.bqn"

t.Run ⟨
  "rotate a by 0, same output as input"‿{𝕊: "a" t.Expect 0 g.Rotate "a"}
  "rotate a by 1"‿{𝕊: "b" t.Expect 1 g.Rotate "a"}
  "rotate a by 26, same output as input"‿{𝕊: "a" t.Expect 26 g.Rotate "a"}
  "rotate m by 13"‿{𝕊: "z" t.Expect 13 g.Rotate "m"}
  "rotate n by 13 with wrap around alphabet"‿{𝕊: "a" t.Expect 13 g.Rotate "n"}
  "rotate capital letters"‿{𝕊: "TRL" t.Expect 5 g.Rotate "OMG"}
  "rotate spaces"‿{𝕊: "T R L" t.Expect 5 g.Rotate "O M G"}
  "rotate numbers"‿{𝕊: "Xiwxmrk 1 2 3 xiwxmrk" t.Expect 4 g.Rotate "Testing 1 2 3 testing"}
  "rotate punctuation"‿{𝕊: "Gzo'n zvo, Bmviyhv!" t.Expect 21 g.Rotate "Let's eat, Grandma!"}
  "rotate all letters"‿{𝕊: "Gur dhvpx oebja sbk whzcf bire gur ynml qbt." t.Expect 13 g.Rotate "The quick brown fox jumps over the lazy dog."}
⟩
