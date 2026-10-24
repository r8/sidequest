t ← •Import "../lib/test.bqn"
g ← •Import "../lost-and-found.bqn"

items ← "umbrella"‿"glove"‿"phone"‿"scarf"

t.Run ⟨
  "1. two items still waiting"‿{𝕊: "glove"‿"phone" t.Expect 1‿0‿0‿1 g.Unclaimed items}
  "1. nothing claimed yet"‿{𝕊: items t.Expect 0‿0‿0‿0 g.Unclaimed items}
  "1. everything claimed"‿{𝕊: ⟨⟩ t.Expect 1‿1‿1‿1 g.Unclaimed items}
  "2. two items over the limit"‿{𝕊: 1‿2 t.Expect 30 g.Overdue 3‿45‿31‿30}
  "2. none over the limit"‿{𝕊: ⟨⟩ t.Expect 60 g.Overdue 3‿45‿31‿30}
  "2. all over the limit"‿{𝕊: 0‿1‿2 t.Expect 0 g.Overdue 1‿2‿3}
  "3. two gloves and a hat"‿{𝕊: "glove"‿"glove"‿"hat" t.Expect 2‿1 g.Expand "glove"‿"hat"}
  "3. a kind with none"‿{𝕊: "key"‿"key"‿"key" t.Expect 0‿3 g.Expand "book"‿"key"}
  "3. one of each"‿{𝕊: "a"‿"b"‿"c" t.Expect 1‿1‿1 g.Expand "a"‿"b"‿"c"}
  "4. letters, dashes and spaces"‿{𝕊: "127" t.Expect g.TicketDigits "A-12 / 7"}
  "4. only digits"‿{𝕊: "0042" t.Expect g.TicketDigits "0042"}
  "4. no digits"‿{𝕊: "" t.Expect g.TicketDigits "lost"}
  "4. nine and zero are digits"‿{𝕊: "90" t.Expect g.TicketDigits "Z9:0Q"}
  "5. an empty shelf in the middle"‿{𝕊: 0‿0‿2‿2‿2 t.Expect g.ShelfNumbers 2‿0‿3}
  "5. one item per shelf"‿{𝕊: 0‿1‿2 t.Expect g.ShelfNumbers 1‿1‿1}
  "5. empty shelves"‿{𝕊: ⟨⟩ t.Expect g.ShelfNumbers 0‿0}
⟩
