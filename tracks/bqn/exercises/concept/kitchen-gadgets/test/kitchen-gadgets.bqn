t ← •Import "../lib/test.bqn"
g ← •Import "../kitchen-gadgets.bqn"

Grate ← ⌊∘(÷⟜2)
Peel ← -⟜1

t.Run ⟨
  "1. subtract twice"‿{𝕊: 4 t.Expect -⟜3 g._twice 10}
  "1. grate twice"‿{𝕊: 25 t.Expect Grate g._twice 100}
  "1. on a list"‿{𝕊: 16‿81 t.Expect ×˜ g._twice 2‿3}
  "1. on a string"‿{𝕊: "pot!!" t.Expect ∾⟜"!" g._twice "pot"}
  "2. double, then add one"‿{𝕊: 11 t.Expect 2⊸× g._then_ (1⊸+) 5}
  "2. add one, then double"‿{𝕊: 12 t.Expect 1⊸+ g._then_ (2⊸×) 5}
  "2. peel, then grate"‿{𝕊: 4 t.Expect Peel g._then_ Grate 10}
  "3. triple a recipe"‿{𝕊: 300‿60‿6 t.Expect 3 g._times 100‿20‿2}
  "3. halve a recipe"‿{𝕊: 50‿10‿1 t.Expect 0.5 g._times 100‿20‿2}
  "3. a single amount"‿{𝕊: 40 t.Expect 4 g._times 10}
  "4. three attachments"‿{𝕊: 6‿10‿¯5 t.Expect ⟨1⊸+, 2⊸×, -⟩ g.ApplyAll 5}
  "4. one attachment"‿{𝕊: ⟨9⟩ t.Expect ⟨Peel⟩ g.ApplyAll 10}
  "4. named attachments"‿{𝕊: 5‿9 t.Expect ⟨grate, peel⟩ g.ApplyAll 10}
  "4. no attachments"‿{𝕊: ⟨⟩ t.Expect ⟨⟩ g.ApplyAll 10}
  "5. a 50 gram scoop"‿{𝕊: add ← g.Scoop 50 ⋄ 170 t.Expect Add 120}
  "5. an empty bowl"‿{𝕊: add ← g.Scoop 25 ⋄ 25 t.Expect Add 0}
  "5. two scoops"‿{𝕊: big‿small ← g.Scoop¨ 100‿5 ⋄ 205 t.Expect Big Small Big 0}
⟩
