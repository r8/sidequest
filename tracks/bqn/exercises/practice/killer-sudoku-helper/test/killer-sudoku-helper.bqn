t ← •Import "../lib/test.bqn"
g ← •Import "../killer-sudoku-helper.bqn"

t.Run ⟨
  "Trivial 1-digit cages > 1"‿{𝕊: ⟨⟨1⟩⟩ t.Expect g.Combinations 1‿1‿⟨⟩}
  "Trivial 1-digit cages > 2"‿{𝕊: ⟨⟨2⟩⟩ t.Expect g.Combinations 2‿1‿⟨⟩}
  "Trivial 1-digit cages > 3"‿{𝕊: ⟨⟨3⟩⟩ t.Expect g.Combinations 3‿1‿⟨⟩}
  "Trivial 1-digit cages > 4"‿{𝕊: ⟨⟨4⟩⟩ t.Expect g.Combinations 4‿1‿⟨⟩}
  "Trivial 1-digit cages > 5"‿{𝕊: ⟨⟨5⟩⟩ t.Expect g.Combinations 5‿1‿⟨⟩}
  "Trivial 1-digit cages > 6"‿{𝕊: ⟨⟨6⟩⟩ t.Expect g.Combinations 6‿1‿⟨⟩}
  "Trivial 1-digit cages > 7"‿{𝕊: ⟨⟨7⟩⟩ t.Expect g.Combinations 7‿1‿⟨⟩}
  "Trivial 1-digit cages > 8"‿{𝕊: ⟨⟨8⟩⟩ t.Expect g.Combinations 8‿1‿⟨⟩}
  "Trivial 1-digit cages > 9"‿{𝕊: ⟨⟨9⟩⟩ t.Expect g.Combinations 9‿1‿⟨⟩}
  "Cage with sum 45 contains all digits 1:9"‿{𝕊: ⟨1‿2‿3‿4‿5‿6‿7‿8‿9⟩ t.Expect g.Combinations 45‿9‿⟨⟩}
  "Cage with only 1 possible combination"‿{𝕊: ⟨1‿2‿4⟩ t.Expect g.Combinations 7‿3‿⟨⟩}
  "Cage with several combinations"‿{𝕊: ⟨1‿9, 2‿8, 3‿7, 4‿6⟩ t.Expect g.Combinations 10‿2‿⟨⟩}
  "Cage with several combinations that is restricted"‿{𝕊: ⟨2‿8, 3‿7⟩ t.Expect g.Combinations 10‿2‿(1‿4)}
⟩
