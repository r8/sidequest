t ← •Import "../lib/test.bqn"
g ← •Import "../queen-attack.bqn"

t.Run ⟨
  "Test creation of Queens with valid and invalid positions > queen with a valid position"‿{𝕊: 2‿2 t.Expect g.Create 2‿2}
  "Test creation of Queens with valid and invalid positions > queen must have positive row"‿{𝕊: {𝕊: g.Create ¯2‿2} t._throws "row not positive"}
  "Test creation of Queens with valid and invalid positions > queen must have row on board"‿{𝕊: {𝕊: g.Create 8‿4} t._throws "row not on board"}
  "Test creation of Queens with valid and invalid positions > queen must have positive column"‿{𝕊: {𝕊: g.Create 2‿¯2} t._throws "column not positive"}
  "Test creation of Queens with valid and invalid positions > queen must have column on board"‿{𝕊: {𝕊: g.Create 4‿8} t._throws "column not on board"}
  "Test the ability of one queen to attack another > cannot attack"‿{𝕊: 0 t.Expect 2‿4 g.CanAttack 6‿6}
  "Test the ability of one queen to attack another > can attack on same row"‿{𝕊: 1 t.Expect 2‿4 g.CanAttack 2‿6}
  "Test the ability of one queen to attack another > can attack on same column"‿{𝕊: 1 t.Expect 4‿5 g.CanAttack 2‿5}
  "Test the ability of one queen to attack another > can attack on first diagonal"‿{𝕊: 1 t.Expect 2‿2 g.CanAttack 0‿4}
  "Test the ability of one queen to attack another > can attack on second diagonal"‿{𝕊: 1 t.Expect 2‿2 g.CanAttack 3‿1}
  "Test the ability of one queen to attack another > can attack on third diagonal"‿{𝕊: 1 t.Expect 2‿2 g.CanAttack 1‿1}
  "Test the ability of one queen to attack another > can attack on fourth diagonal"‿{𝕊: 1 t.Expect 1‿7 g.CanAttack 0‿6}
  "Test the ability of one queen to attack another > cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal"‿{𝕊: 0 t.Expect 4‿1 g.CanAttack 2‿5}
⟩
