t ← •Import "../lib/test.bqn"
g ← •Import "../moving-boxes.bqn"

t.Run ⟨
  "1. an item on its own"‿{𝕊: 0 t.Expect g.Layers 7}
  "1. a box of items"‿{𝕊: 1 t.Expect g.Layers 1‿2‿3}
  "1. a box inside a box"‿{𝕊: 2 t.Expect g.Layers ⟨1, ⟨2, 3⟩, 4⟩}
  "1. the deepest item counts"‿{𝕊: 4 t.Expect g.Layers ⟨1, ⟨2, ⟨3, ⟨4⟩⟩⟩, 5‿6⟩}
  "1. an empty box"‿{𝕊: 1 t.Expect g.Layers ⟨⟩}
  "2. boxes of items"‿{𝕊: 1‿2‿3‿4 t.Expect g.Unpack ⟨1‿2, ⟨3⟩, ⟨4⟩⟩}
  "2. an empty box adds nothing"‿{𝕊: 1‿2‿3 t.Expect g.Unpack ⟨1‿2, ⟨⟩, ⟨3⟩⟩}
  "2. boxes inside stay closed"‿{𝕊: ⟨1, 2, 3, 4, 5‿6⟩ t.Expect g.Unpack ⟨1‿2, ⟨3⟩, ⟨⟩, ⟨4, 5‿6⟩⟩}
  "2. a single box"‿{𝕊: 9‿8 t.Expect g.Unpack ⟨9‿8⟩}
  "3. add an item"‿{𝕊: 1‿2‿3 t.Expect 1‿2 g.AddItem 3}
  "3. add a box as one element"‿{𝕊: ⟨1, 2, 3‿4⟩ t.Expect 1‿2 g.AddItem 3‿4}
  "3. add to an empty box"‿{𝕊: ⟨5‿6‿7⟩ t.Expect ⟨⟩ g.AddItem 5‿6‿7}
  "3. add an empty box"‿{𝕊: ⟨1, ⟨⟩⟩ t.Expect ⟨1⟩ g.AddItem ⟨⟩}
  "4. label a box"‿{𝕊: ⟨"kitchen", 1‿2‿3⟩ t.Expect "kitchen" g.Label 1‿2‿3}
  "4. label a box of boxes"‿{𝕊: ⟨"books", ⟨1‿2, 3‿4⟩⟩ t.Expect "books" g.Label ⟨1‿2, 3‿4⟩}
  "4. a label and a box make two elements"‿{𝕊: 2 t.Expect ≠ "x" g.Label 1‿2‿3‿4‿5}
  "5. two boxes of three"‿{𝕊: (2‿3 ⥊ 1‿2‿3‿4‿5‿6) t.Expect g.Shelve ⟨1‿2‿3, 4‿5‿6⟩}
  "5. three boxes of two"‿{𝕊: 3‿2 t.Expect ≢ g.Shelve ⟨1‿2, 3‿4, 5‿6⟩}
  "5. one box"‿{𝕊: (1‿4 ⥊ 9‿8‿7‿6) t.Expect g.Shelve ⟨9‿8‿7‿6⟩}
  "6. two identical boxes"‿{𝕊: 1‿0‿0‿1 t.Expect ⟨1‿2, 2‿1, 1‿2‿3, 1‿2⟩ g.Matches 1‿2}
  "6. no identical box"‿{𝕊: 0‿0 t.Expect ⟨1‿2, 3‿4⟩ g.Matches 1‿3}
  "6. boxes inside boxes must match too"‿{𝕊: 0‿1 t.Expect ⟨⟨1, 2‿3⟩, ⟨1, 2‿3‿4⟩⟩ g.Matches ⟨1, 2‿3‿4⟩}
  "6. empty boxes match"‿{𝕊: 1‿0‿1 t.Expect ⟨⟨⟩, ⟨0⟩, ⟨⟩⟩ g.Matches ⟨⟩}
⟩
