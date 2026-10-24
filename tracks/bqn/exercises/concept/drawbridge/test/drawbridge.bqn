t ← •Import "../lib/test.bqn"
g ← •Import "../drawbridge.bqn"

t.Run ⟨
  "1. a small sailing boat fits"‿{𝕊: 1 t.Expect g.CanPass 4.5}
  "1. a tall ship does not"‿{𝕊: 0 t.Expect g.CanPass 12}
  "1. a mast of exactly 6 metres does not"‿{𝕊: 0 t.Expect g.CanPass 6}
  "2. morning rush hour"‿{𝕊: 1 t.Expect g.IsRushHour 8}
  "2. the first hour of rush hour"‿{𝕊: 1 t.Expect g.IsRushHour 7}
  "2. the last hour of evening rush hour"‿{𝕊: 1 t.Expect g.IsRushHour 18}
  "2. midday"‿{𝕊: 0 t.Expect g.IsRushHour 12}
  "2. late at night"‿{𝕊: 0 t.Expect g.IsRushHour 23}
  "3. a tall boat at midday"‿{𝕊: 1 t.Expect 12 g.MustRaise 9}
  "3. a tall boat in rush hour waits"‿{𝕊: 0 t.Expect 17 g.MustRaise 9}
  "3. a small boat at midday passes underneath"‿{𝕊: 0 t.Expect 12 g.MustRaise 3}
  "3. a small boat in rush hour"‿{𝕊: 0 t.Expect 8 g.MustRaise 3}
  "4. a visitor's car"‿{𝕊: 2 t.Expect 0 g.Toll 0}
  "4. a visitor with a trailer"‿{𝕊: 5 t.Expect 0 g.Toll 1}
  "4. a resident's car"‿{𝕊: 0 t.Expect 1 g.Toll 0}
  "4. a resident with a trailer"‿{𝕊: 0 t.Expect 1 g.Toll 1}
  "5. both lamps lit"‿{𝕊: 0 t.Expect 1 g.BulbBlown 1}
  "5. both lamps dark"‿{𝕊: 0 t.Expect 0 g.BulbBlown 0}
  "5. only the first lamp lit"‿{𝕊: 1 t.Expect 1 g.BulbBlown 0}
  "5. only the second lamp lit"‿{𝕊: 1 t.Expect 0 g.BulbBlown 1}
⟩
