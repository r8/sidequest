t ← •Import "../lib/test.bqn"
g ← •Import "../sum-of-multiples.bqn"

t.Run ⟨
  "no multiples within limit"‿{𝕊: 0 t.Expect 3‿5 g.Sum 1}
  "one factor has multiples within limit"‿{𝕊: 3 t.Expect 3‿5 g.Sum 4}
  "more than one multiple within limit"‿{𝕊: 9 t.Expect ⟨3⟩ g.Sum 7}
  "more than one factor with multiples within limit"‿{𝕊: 23 t.Expect 3‿5 g.Sum 10}
  "each multiple is only counted once"‿{𝕊: 2318 t.Expect 3‿5 g.Sum 100}
  "a much larger limit"‿{𝕊: 233168 t.Expect 3‿5 g.Sum 1000}
  "three factors"‿{𝕊: 51 t.Expect 7‿13‿17 g.Sum 20}
  "factors not relatively prime"‿{𝕊: 30 t.Expect 4‿6 g.Sum 15}
  "some pairs of factors relatively prime and some not"‿{𝕊: 4419 t.Expect 5‿6‿8 g.Sum 150}
  "one factor is a multiple of another"‿{𝕊: 275 t.Expect 5‿25 g.Sum 51}
  "much larger factors"‿{𝕊: 2203160 t.Expect 43‿47 g.Sum 10000}
  "all numbers are multiples of 1"‿{𝕊: 4950 t.Expect ⟨1⟩ g.Sum 100}
  "no factors means an empty sum"‿{𝕊: 0 t.Expect ⟨⟩ g.Sum 10000}
  "the only multiple of 0 is 0"‿{𝕊: 0 t.Expect ⟨0⟩ g.Sum 1}
  "the factor 0 does not affect the sum of multiples of other factors"‿{𝕊: 3 t.Expect 3‿0 g.Sum 4}
  "solutions using include-exclude must extend to cardinality greater than 3"‿{𝕊: 39614537 t.Expect 2‿3‿5‿7‿11 g.Sum 10000}
⟩
