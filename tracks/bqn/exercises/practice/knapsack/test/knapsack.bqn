t ← •Import "../lib/test.bqn"
g ← •Import "../knapsack.bqn"

items15 ← ⟨70‿135, 73‿139, 77‿149, 80‿150, 82‿156, 87‿163, 90‿173, 94‿184, 98‿192, 106‿201, 110‿210, 113‿214, 115‿221, 118‿229, 120‿240⟩

t.Run ⟨
  "no items"‿{𝕊: 0 t.Expect 100 g.MaximumValue ⟨⟩}
  "one item, too heavy"‿{𝕊: 0 t.Expect 10 g.MaximumValue ⟨100‿1⟩}
  "five items (cannot be greedy by weight)"‿{𝕊: 21 t.Expect 10 g.MaximumValue ⟨2‿5, 2‿5, 2‿5, 2‿5, 10‿21⟩}
  "five items (cannot be greedy by value)"‿{𝕊: 80 t.Expect 10 g.MaximumValue ⟨2‿20, 2‿20, 2‿20, 2‿20, 10‿50⟩}
  "example knapsack"‿{𝕊: 90 t.Expect 10 g.MaximumValue ⟨5‿10, 4‿40, 6‿30, 4‿50⟩}
  "8 items"‿{𝕊: 900 t.Expect 104 g.MaximumValue ⟨25‿350, 35‿400, 45‿450, 5‿20, 25‿70, 3‿8, 2‿5, 2‿5⟩}
  "15 items"‿{𝕊: 1458 t.Expect 750 g.MaximumValue items15}
⟩
