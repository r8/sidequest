t ← •Import "../lib/test.bqn"
g ← •Import "../nth-prime.bqn"

t.Run ⟨
  "first prime"‿{𝕊: 2 t.Expect g.Prime 1}
  "second prime"‿{𝕊: 3 t.Expect g.Prime 2}
  "sixth prime"‿{𝕊: 13 t.Expect g.Prime 6}
  "big prime"‿{𝕊: 104743 t.Expect g.Prime 10001}
  "there is no zeroth prime"‿{𝕊: {𝕊: g.Prime 0} t._throws "there is no zeroth prime"}
⟩
