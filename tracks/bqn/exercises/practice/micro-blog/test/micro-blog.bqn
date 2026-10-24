t ← •Import "../lib/test.bqn"
g ← •Import "../micro-blog.bqn"

t.Run ⟨
  "English language short"‿{𝕊: "Hi" t.Expect g.Truncate "Hi"}
  "English language long"‿{𝕊: "Hello" t.Expect g.Truncate "Hello there"}
  "German language short (broth)"‿{𝕊: "brühe" t.Expect g.Truncate "brühe"}
  "German language long (bear carpet → beards)"‿{𝕊: "Bärte" t.Expect g.Truncate "Bärteppich"}
  "Bulgarian language short (good)"‿{𝕊: "Добър" t.Expect g.Truncate "Добър"}
  "Greek language short (health)"‿{𝕊: "υγειά" t.Expect g.Truncate "υγειά"}
  "Maths short"‿{𝕊: "a=πr²" t.Expect g.Truncate "a=πr²"}
  "Maths long"‿{𝕊: "∅⊊ℕ⊊ℤ" t.Expect g.Truncate "∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ"}
  "English and emoji short"‿{𝕊: "Fly 🛫" t.Expect g.Truncate "Fly 🛫"}
  "Emoji short"‿{𝕊: "💇" t.Expect g.Truncate "💇"}
  "Emoji long"‿{𝕊: "❄🌡🤧🤒🏥" t.Expect g.Truncate "❄🌡🤧🤒🏥🕰😀"}
  "Royal Flush?"‿{𝕊: "🃎🂸🃅🃋🃍" t.Expect g.Truncate "🃎🂸🃅🃋🃍🃁🃊"}
⟩
