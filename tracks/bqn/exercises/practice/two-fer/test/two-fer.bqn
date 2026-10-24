t ← •Import "../lib/test.bqn"
g ← •Import "../two-fer.bqn"

t.Run ⟨
  "no name given"‿{𝕊: "One for you, one for me." t.Expect g.TwoFer ""}
  "a name given"‿{𝕊: "One for Alice, one for me." t.Expect g.TwoFer "Alice"}
  "another name given"‿{𝕊: "One for Bob, one for me." t.Expect g.TwoFer "Bob"}
⟩
