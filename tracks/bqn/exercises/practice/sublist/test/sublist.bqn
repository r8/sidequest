t ← •Import "../lib/test.bqn"
g ← •Import "../sublist.bqn"

t.Run ⟨
  "empty lists"‿{𝕊: "equal" t.Expect ⟨⟩ g.Sublist ⟨⟩}
  "empty list within non empty list"‿{𝕊: "sublist" t.Expect ⟨⟩ g.Sublist 1‿2‿3}
  "non empty list contains empty list"‿{𝕊: "superlist" t.Expect 1‿2‿3 g.Sublist ⟨⟩}
  "list equals itself"‿{𝕊: "equal" t.Expect 1‿2‿3 g.Sublist 1‿2‿3}
  "different lists"‿{𝕊: "unequal" t.Expect 1‿2‿3 g.Sublist 2‿3‿4}
  "false start"‿{𝕊: "sublist" t.Expect 1‿2‿5 g.Sublist 0‿1‿2‿3‿1‿2‿5‿6}
  "consecutive"‿{𝕊: "sublist" t.Expect 1‿1‿2 g.Sublist 0‿1‿1‿1‿2‿1‿2}
  "sublist at start"‿{𝕊: "sublist" t.Expect 0‿1‿2 g.Sublist 0‿1‿2‿3‿4‿5}
  "sublist in middle"‿{𝕊: "sublist" t.Expect 2‿3‿4 g.Sublist 0‿1‿2‿3‿4‿5}
  "sublist at end"‿{𝕊: "sublist" t.Expect 3‿4‿5 g.Sublist 0‿1‿2‿3‿4‿5}
  "at start of superlist"‿{𝕊: "superlist" t.Expect 0‿1‿2‿3‿4‿5 g.Sublist 0‿1‿2}
  "in middle of superlist"‿{𝕊: "superlist" t.Expect 0‿1‿2‿3‿4‿5 g.Sublist 2‿3}
  "at end of superlist"‿{𝕊: "superlist" t.Expect 0‿1‿2‿3‿4‿5 g.Sublist 3‿4‿5}
  "first list missing element from second list"‿{𝕊: "unequal" t.Expect 1‿3 g.Sublist 1‿2‿3}
  "second list missing element from first list"‿{𝕊: "unequal" t.Expect 1‿2‿3 g.Sublist 1‿3}
  "first list missing additional digits from second list"‿{𝕊: "unequal" t.Expect 1‿2 g.Sublist 1‿22}
  "order matters to a list"‿{𝕊: "unequal" t.Expect 1‿2‿3 g.Sublist 3‿2‿1}
  "same digits but different numbers"‿{𝕊: "unequal" t.Expect 1‿0‿1 g.Sublist 10‿1}
⟩
