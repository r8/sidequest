t ← •Import "../lib/test.bqn"
g ← •Import "../darts.bqn"

t.Run ⟨
  "Missed target"‿{𝕊: 0 t.Expect g.Score ¯9‿9}
  "On the outer circle"‿{𝕊: 1 t.Expect g.Score 0‿10}
  "On the middle circle"‿{𝕊: 5 t.Expect g.Score ¯5‿0}
  "On the inner circle"‿{𝕊: 10 t.Expect g.Score 0‿¯1}
  "Exactly on center"‿{𝕊: 10 t.Expect g.Score 0‿0}
  "Near the center"‿{𝕊: 10 t.Expect g.Score ¯0.1‿¯0.1}
  "Just within the inner circle"‿{𝕊: 10 t.Expect g.Score 0.7‿0.7}
  "Just outside the inner circle"‿{𝕊: 5 t.Expect g.Score 0.8‿¯0.8}
  "Just within the middle circle"‿{𝕊: 5 t.Expect g.Score ¯3.5‿3.5}
  "Just outside the middle circle"‿{𝕊: 1 t.Expect g.Score ¯3.6‿¯3.6}
  "Just within the outer circle"‿{𝕊: 1 t.Expect g.Score ¯7‿7}
  "Just outside the outer circle"‿{𝕊: 0 t.Expect g.Score 7.1‿¯7.1}
  "Asymmetric position between the inner and middle circles"‿{𝕊: 5 t.Expect g.Score 0.5‿¯4}
⟩
