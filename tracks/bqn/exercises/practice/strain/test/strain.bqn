t ← •Import "../lib/test.bqn"
g ← •Import "../strain.bqn"

Odd ← 2⊸|
Even ← 0=2⊸|
StartsWithZ ← 'z'=⊑
Contains5 ← ∨´5⊸=
words ← "apple"‿"zebra"‿"banana"‿"zombies"‿"cherimoya"‿"zealot"
lists ← ⟨1‿2‿3, 5‿5‿5, 5‿1‿2, 2‿1‿2, 1‿5‿2, 2‿2‿1, 1‿2‿5⟩

t.Run ⟨
  "keep on empty list returns empty list"‿{𝕊: ⟨⟩ t.Expect {𝕊: 1} g._keep ⟨⟩}
  "keeps everything"‿{𝕊: 1‿3‿5 t.Expect {𝕊: 1} g._keep 1‿3‿5}
  "keeps nothing"‿{𝕊: ⟨⟩ t.Expect {𝕊: 0} g._keep 1‿3‿5}
  "keeps first and last"‿{𝕊: 1‿3 t.Expect Odd g._keep 1‿2‿3}
  "keeps neither first nor last"‿{𝕊: ⟨2⟩ t.Expect Even g._keep 1‿2‿3}
  "keeps strings"‿{𝕊: "zebra"‿"zombies"‿"zealot" t.Expect StartsWithZ g._keep words}
  "keeps lists"‿{𝕊: ⟨5‿5‿5, 5‿1‿2, 1‿5‿2, 1‿2‿5⟩ t.Expect Contains5 g._keep lists}
  "discard on empty list returns empty list"‿{𝕊: ⟨⟩ t.Expect {𝕊: 1} g._discard ⟨⟩}
  "discards everything"‿{𝕊: ⟨⟩ t.Expect {𝕊: 1} g._discard 1‿3‿5}
  "discards nothing"‿{𝕊: 1‿3‿5 t.Expect {𝕊: 0} g._discard 1‿3‿5}
  "discards first and last"‿{𝕊: ⟨2⟩ t.Expect Odd g._discard 1‿2‿3}
  "discards neither first nor last"‿{𝕊: 1‿3 t.Expect Even g._discard 1‿2‿3}
  "discards strings"‿{𝕊: "apple"‿"banana"‿"cherimoya" t.Expect StartsWithZ g._discard words}
  "discards lists"‿{𝕊: ⟨1‿2‿3, 2‿1‿2, 2‿2‿1⟩ t.Expect Contains5 g._discard lists}
⟩
