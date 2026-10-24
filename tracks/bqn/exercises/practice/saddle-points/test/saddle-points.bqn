t ← •Import "../lib/test.bqn"
g ← •Import "../saddle-points.bqn"

t.Run ⟨
  "Can identify single saddle point"‿{𝕊: ⟨2‿1⟩ t.Expect g.SaddlePoints ⟨9‿8‿7, 5‿3‿2, 6‿6‿7⟩}
  "Can identify that empty matrix has no saddle points"‿{𝕊: ⟨⟩ t.Expect g.SaddlePoints ⟨⟨⟩⟩}
  "Can identify lack of saddle points when there are none"‿{𝕊: ⟨⟩ t.Expect g.SaddlePoints ⟨1‿2‿3, 3‿1‿2, 2‿3‿1⟩}
  "Can identify multiple saddle points in a column"‿{𝕊: ⟨1‿2, 2‿2, 3‿2⟩ t.Expect g.SaddlePoints ⟨4‿5‿4, 3‿5‿5, 1‿5‿4⟩}
  "Can identify multiple saddle points in a row"‿{𝕊: ⟨2‿1, 2‿2, 2‿3⟩ t.Expect g.SaddlePoints ⟨6‿7‿8, 5‿5‿5, 7‿5‿6⟩}
  "Can identify saddle point in bottom right corner"‿{𝕊: ⟨3‿3⟩ t.Expect g.SaddlePoints ⟨8‿7‿9, 6‿7‿6, 3‿2‿5⟩}
  "Can identify saddle points in a non square matrix"‿{𝕊: ⟨1‿1, 1‿3⟩ t.Expect g.SaddlePoints ⟨3‿1‿3, 3‿2‿4⟩}
  "Can identify that saddle points in a single column matrix are those with the minimum value"‿{𝕊: ⟨2‿1, 4‿1⟩ t.Expect g.SaddlePoints ⟨⟨2⟩, ⟨1⟩, ⟨4⟩, ⟨1⟩⟩}
  "Can identify that saddle points in a single row matrix are those with the maximum value"‿{𝕊: ⟨1‿2, 1‿4⟩ t.Expect g.SaddlePoints ⟨2‿5‿3‿5⟩}
⟩
