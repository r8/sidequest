t ← •Import "../lib/test.bqn"
g ← •Import "../prime-factors.bqn"

t.Run ⟨
  "no factors"‿{𝕊: ⟨⟩ t.Expect g.Factors 1}
  "prime number"‿{𝕊: ⟨2⟩ t.Expect g.Factors 2}
  "another prime number"‿{𝕊: ⟨3⟩ t.Expect g.Factors 3}
  "square of a prime"‿{𝕊: 3‿3 t.Expect g.Factors 9}
  "product of first prime"‿{𝕊: 2‿2 t.Expect g.Factors 4}
  "cube of a prime"‿{𝕊: 2‿2‿2 t.Expect g.Factors 8}
  "product of second prime"‿{𝕊: 3‿3‿3 t.Expect g.Factors 27}
  "product of third prime"‿{𝕊: 5‿5‿5‿5 t.Expect g.Factors 625}
  "product of first and second prime"‿{𝕊: 2‿3 t.Expect g.Factors 6}
  "product of primes and non-primes"‿{𝕊: 2‿2‿3 t.Expect g.Factors 12}
  "product of primes"‿{𝕊: 5‿17‿23‿461 t.Expect g.Factors 901255}
  "factors include a large prime"‿{𝕊: 11‿9539‿894119 t.Expect g.Factors 93819012551}
⟩
