t ← •Import "../lib/test.bqn"
g ← •Import "../pangram.bqn"

t.Run ⟨
  "empty sentence"‿{𝕊: 0 t.Expect g.IsPangram ""}
  "perfect lower case"‿{𝕊: 1 t.Expect g.IsPangram "abcdefghijklmnopqrstuvwxyz"}
  "only lower case"‿{𝕊: 1 t.Expect g.IsPangram "the quick brown fox jumps over the lazy dog"}
  "missing the letter 'x'"‿{𝕊: 0 t.Expect g.IsPangram "a quick movement of the enemy will jeopardize five gunboats"}
  "missing the letter 'h'"‿{𝕊: 0 t.Expect g.IsPangram "five boxing wizards jump quickly at it"}
  "with underscores"‿{𝕊: 1 t.Expect g.IsPangram "the_quick_brown_fox_jumps_over_the_lazy_dog"}
  "with numbers"‿{𝕊: 1 t.Expect g.IsPangram "the 1 quick brown fox jumps over the 2 lazy dogs"}
  "missing letters replaced by numbers"‿{𝕊: 0 t.Expect g.IsPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"}
  "mixed case and punctuation"‿{𝕊: 1 t.Expect g.IsPangram """Five quacking Zephyrs jolt my wax bed."""}
  "a-m and A-M are 26 different characters but not a pangram"‿{𝕊: 0 t.Expect g.IsPangram "abcdefghijklm ABCDEFGHIJKLM"}
⟩
