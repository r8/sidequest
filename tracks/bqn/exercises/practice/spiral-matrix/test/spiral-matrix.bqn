t ← •Import "../lib/test.bqn"
g ← •Import "../spiral-matrix.bqn"

t.Run ⟨
  "empty spiral"‿{𝕊: (0‿0⥊0) t.Expect g.SpiralMatrix 0}
  "trivial spiral"‿{𝕊: (1‿1⥊1) t.Expect g.SpiralMatrix 1}
  "spiral of size 2"‿{𝕊: (>⟨1‿2, 4‿3⟩) t.Expect g.SpiralMatrix 2}
  "spiral of size 3"‿{𝕊: (>⟨1‿2‿3, 8‿9‿4, 7‿6‿5⟩) t.Expect g.SpiralMatrix 3}
  "spiral of size 4"‿{𝕊: (>⟨1‿2‿3‿4, 12‿13‿14‿5, 11‿16‿15‿6, 10‿9‿8‿7⟩) t.Expect g.SpiralMatrix 4}
  "spiral of size 5"‿{𝕊: (>⟨1‿2‿3‿4‿5, 16‿17‿18‿19‿6, 15‿24‿25‿20‿7, 14‿23‿22‿21‿8, 13‿12‿11‿10‿9⟩) t.Expect g.SpiralMatrix 5}
⟩
