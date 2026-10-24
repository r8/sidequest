t ← •Import "../lib/test.bqn"
g ← •Import "../statistics-club.bqn"

t.Run ⟨
  "1. three bean plants"‿{𝕊: 5 t.Approx g.Mean 2‿4‿9}
  "1. a single measurement"‿{𝕊: 7 t.Approx g.Mean ⟨7⟩}
  "1. a mean that is not whole"‿{𝕊: 2.5 t.Approx g.Mean 1‿2‿3‿4}
  "1. negative values"‿{𝕊: ¯1 t.Approx g.Mean ¯3‿1‿¯1}
  "2. a spread of values"‿{𝕊: 8 t.Expect g.Range 3‿9‿1}
  "2. all the same"‿{𝕊: 0 t.Expect g.Range 4‿4‿4}
  "2. negative values"‿{𝕊: 7 t.Expect g.Range ¯5‿2‿0}
  "3. three bean plants"‿{𝕊: ¯3‿¯1‿4 t.Expect g.Deviations 2‿4‿9}
  "3. all the same"‿{𝕊: 0‿0‿0 t.Expect g.Deviations 6‿6‿6}
  "3. a single measurement"‿{𝕊: ⟨0⟩ t.Expect g.Deviations ⟨12⟩}
  "4. the classic example"‿{𝕊: 4 t.Approx g.Variance 2‿4‿4‿4‿5‿5‿7‿9}
  "4. all the same"‿{𝕊: 0 t.Approx g.Variance 3‿3‿3}
  "4. two values"‿{𝕊: 1 t.Approx g.Variance 1‿3}
  "5. some above"‿{𝕊: 2 t.Expect 5 g.Above 3‿7‿9‿5}
  "5. none above"‿{𝕊: 0 t.Expect 10 g.Above 3‿7‿9‿5}
  "5. all above"‿{𝕊: 4 t.Expect 0 g.Above 3‿7‿9‿5}
  "5. no values"‿{𝕊: 0 t.Expect 5 g.Above ⟨⟩}
  "6. unequal weights"‿{𝕊: 17.5 t.Approx 1‿3 g.WeightedMean 10‿20}
  "6. equal weights give the mean"‿{𝕊: 5 t.Approx 2‿2‿2 g.WeightedMean 2‿4‿9}
  "6. a weight of zero ignores the value"‿{𝕊: 8 t.Approx 1‿0‿1 g.WeightedMean 6‿100‿10}
⟩
