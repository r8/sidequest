t ← •Import "../lib/test.bqn"
g ← •Import "../pascals-triangle.bqn"

t.Run ⟨
  "zero rows"‿{𝕊: ⟨⟩ t.Expect g.Rows 0}
  "single row"‿{𝕊: ⟨⟨1⟩⟩ t.Expect g.Rows 1}
  "two rows"‿{𝕊: ⟨⟨1⟩, 1‿1⟩ t.Expect g.Rows 2}
  "three rows"‿{𝕊: ⟨⟨1⟩, 1‿1, 1‿2‿1⟩ t.Expect g.Rows 3}
  "four rows"‿{𝕊: ⟨⟨1⟩, 1‿1, 1‿2‿1, 1‿3‿3‿1⟩ t.Expect g.Rows 4}
  "five rows"‿{𝕊: ⟨⟨1⟩, 1‿1, 1‿2‿1, 1‿3‿3‿1, 1‿4‿6‿4‿1⟩ t.Expect g.Rows 5}
  "six rows"‿{𝕊: ⟨⟨1⟩, 1‿1, 1‿2‿1, 1‿3‿3‿1, 1‿4‿6‿4‿1, 1‿5‿10‿10‿5‿1⟩ t.Expect g.Rows 6}
  "ten rows"‿{𝕊:
    ten ← ⟨
      ⟨1⟩, 1‿1, 1‿2‿1, 1‿3‿3‿1, 1‿4‿6‿4‿1, 1‿5‿10‿10‿5‿1, 1‿6‿15‿20‿15‿6‿1
      1‿7‿21‿35‿35‿21‿7‿1, 1‿8‿28‿56‿70‿56‿28‿8‿1, 1‿9‿36‿84‿126‿126‿84‿36‿9‿1
    ⟩
    ten t.Expect g.Rows 10
  }
⟩
