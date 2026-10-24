t ← •Import "../lib/test.bqn"
g ← •Import "../collatz-conjecture.bqn"

t.Run ⟨
  "zero steps for one"‿{𝕊: 0 t.Expect g.Steps 1}
  "divide if even"‿{𝕊: 4 t.Expect g.Steps 16}
  "even and odd steps"‿{𝕊: 9 t.Expect g.Steps 12}
  "large number of even and odd steps"‿{𝕊: 152 t.Expect g.Steps 1000000}
  "zero is an error"‿{𝕊: {𝕊: g.Steps 0} t._throws "Only positive integers are allowed"}
  "negative value is an error"‿{𝕊: {𝕊: g.Steps ¯15} t._throws "Only positive integers are allowed"}
⟩
