t ← •Import "../lib/test.bqn"
g ← •Import "../yacht.bqn"

t.Run ⟨
  "Yacht"‿{𝕊: 50 t.Expect 5‿5‿5‿5‿5 g.Score "yacht"}
  "Not Yacht"‿{𝕊: 0 t.Expect 1‿3‿3‿2‿5 g.Score "yacht"}
  "Ones"‿{𝕊: 3 t.Expect 1‿1‿1‿3‿5 g.Score "ones"}
  "Ones, out of order"‿{𝕊: 3 t.Expect 3‿1‿1‿5‿1 g.Score "ones"}
  "No ones"‿{𝕊: 0 t.Expect 4‿3‿6‿5‿5 g.Score "ones"}
  "Twos"‿{𝕊: 2 t.Expect 2‿3‿4‿5‿6 g.Score "twos"}
  "Fours"‿{𝕊: 8 t.Expect 1‿4‿1‿4‿1 g.Score "fours"}
  "Yacht counted as threes"‿{𝕊: 15 t.Expect 3‿3‿3‿3‿3 g.Score "threes"}
  "Yacht of 3s counted as fives"‿{𝕊: 0 t.Expect 3‿3‿3‿3‿3 g.Score "fives"}
  "Fives"‿{𝕊: 10 t.Expect 1‿5‿3‿5‿3 g.Score "fives"}
  "Sixes"‿{𝕊: 6 t.Expect 2‿3‿4‿5‿6 g.Score "sixes"}
  "Full house two small, three big"‿{𝕊: 16 t.Expect 2‿2‿4‿4‿4 g.Score "full house"}
  "Full house three small, two big"‿{𝕊: 19 t.Expect 5‿3‿3‿5‿3 g.Score "full house"}
  "Two pair is not a full house"‿{𝕊: 0 t.Expect 2‿2‿4‿4‿5 g.Score "full house"}
  "Four of a kind is not a full house"‿{𝕊: 0 t.Expect 1‿4‿4‿4‿4 g.Score "full house"}
  "Yacht is not a full house"‿{𝕊: 0 t.Expect 2‿2‿2‿2‿2 g.Score "full house"}
  "Four of a Kind"‿{𝕊: 24 t.Expect 6‿6‿4‿6‿6 g.Score "four of a kind"}
  "Yacht can be scored as Four of a Kind"‿{𝕊: 12 t.Expect 3‿3‿3‿3‿3 g.Score "four of a kind"}
  "Full house is not Four of a Kind"‿{𝕊: 0 t.Expect 3‿3‿3‿5‿5 g.Score "four of a kind"}
  "Little Straight"‿{𝕊: 30 t.Expect 3‿5‿4‿1‿2 g.Score "little straight"}
  "Little Straight as Big Straight"‿{𝕊: 0 t.Expect 1‿2‿3‿4‿5 g.Score "big straight"}
  "Four in order but not a little straight"‿{𝕊: 0 t.Expect 1‿1‿2‿3‿4 g.Score "little straight"}
  "No pairs but not a little straight"‿{𝕊: 0 t.Expect 1‿2‿3‿4‿6 g.Score "little straight"}
  "Minimum is 1, maximum is 5, but not a little straight"‿{𝕊: 0 t.Expect 1‿1‿3‿4‿5 g.Score "little straight"}
  "Big Straight"‿{𝕊: 30 t.Expect 4‿6‿2‿5‿3 g.Score "big straight"}
  "Big Straight as little straight"‿{𝕊: 0 t.Expect 6‿5‿4‿3‿2 g.Score "little straight"}
  "No pairs but not a big straight"‿{𝕊: 0 t.Expect 6‿5‿4‿3‿1 g.Score "big straight"}
  "Choice"‿{𝕊: 23 t.Expect 3‿3‿5‿6‿6 g.Score "choice"}
  "Yacht as choice"‿{𝕊: 10 t.Expect 2‿2‿2‿2‿2 g.Score "choice"}
⟩
