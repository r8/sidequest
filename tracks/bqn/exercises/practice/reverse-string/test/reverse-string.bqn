t ← •Import "../lib/test.bqn"
g ← •Import "../reverse-string.bqn"

t.Run ⟨
  "an empty string"‿{𝕊: "" t.Expect g.Reverse ""}
  "a word"‿{𝕊: "tobor" t.Expect g.Reverse "robot"}
  "a capitalized word"‿{𝕊: "nemaR" t.Expect g.Reverse "Ramen"}
  "a sentence with punctuation"‿{𝕊: "!yrgnuh m'I" t.Expect g.Reverse "I'm hungry!"}
  "a palindrome"‿{𝕊: "racecar" t.Expect g.Reverse "racecar"}
  "an even-sized word"‿{𝕊: "reward" t.Expect g.Reverse "drawer"}
  "wide characters"‿{𝕊: "猫子" t.Expect g.Reverse "子猫"}
  "grapheme cluster with pre-combined form"‿{𝕊: "dnatsnehctsrüW" t.Expect g.Reverse "Würstchenstand"}
⟩
