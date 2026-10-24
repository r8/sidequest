t ← •Import "../lib/test.bqn"
g ← •Import "../mail-room.bqn"

sack ← "card"‿"bill"‿"note"‿"ad"‿"parcel"

t.Run ⟨
  "1. letters for three floors"‿{𝕊: ⟨⟨"bill"⟩, ⟨"note"⟩, "card"‿"ad"⟩ t.Expect 2‿0‿1‿2‿¯1 g.ByFloor sack}
  "1. a letter without an address goes back"‿{𝕊: ⟨⟨"bill"⟩, ⟨"parcel"⟩, "card"‿"note"⟩ t.Expect 2‿0‿2‿¯1‿1 g.ByFloor sack}
  "1. a floor with no mail gets an empty pile"‿{𝕊: ⟨⟨"card"⟩, ⟨⟩, ⟨⟩, "bill"‿"note"⟩ t.Expect 0‿3‿3 g.ByFloor 3↑sack}
  "1. everything for the ground floor"‿{𝕊: ⟨sack⟩ t.Expect 0‿0‿0‿0‿0 g.ByFloor sack}
  "2. counts for three floors"‿{𝕊: 1‿1‿2 t.Expect g.LettersPerFloor 2‿0‿2‿¯1‿1}
  "2. a floor with no mail counts zero"‿{𝕊: 2‿0‿1 t.Expect g.LettersPerFloor 0‿2‿0}
  "2. one letter"‿{𝕊: ⟨1⟩ t.Expect g.LettersPerFloor ⟨0⟩}
  "3. a resident without mail"‿{𝕊: ⟨⟨"Ana"⟩, ⟨⟩, "Cy"‿"Cy"⟩ t.Expect "Ana"‿"Bo"‿"Cy" g.Pigeonholes "Cy"‿"Ana"‿"Cy"}
  "3. the last resident has no mail"‿{𝕊: ⟨"Ana"‿"Ana", ⟨"Bo"⟩, ⟨⟩⟩ t.Expect "Ana"‿"Bo"‿"Cy" g.Pigeonholes "Ana"‿"Bo"‿"Ana"}
  "3. no mail at all"‿{𝕊: ⟨⟨⟩, ⟨⟩⟩ t.Expect "Ana"‿"Bo" g.Pigeonholes ⟨⟩}
  "3. one letter each"‿{𝕊: ⟨⟨"Ana"⟩, ⟨"Bo"⟩⟩ t.Expect "Ana"‿"Bo" g.Pigeonholes "Bo"‿"Ana"}
  "4. bundles of two"‿{𝕊: ⟨"card"‿"bill", "note"‿"ad", ⟨"parcel"⟩⟩ t.Expect 2 g.Trips sack}
  "4. bundles of five"‿{𝕊: ⟨sack⟩ t.Expect 5 g.Trips sack}
  "4. one letter at a time"‿{𝕊: ⟨⟨"card"⟩, ⟨"bill"⟩, ⟨"note"⟩⟩ t.Expect 1 g.Trips 3↑sack}
  "4. bundles that come out even"‿{𝕊: ⟨"card"‿"bill"‿"note", "ad"‿"parcel"‿"card"⟩ t.Expect 3 g.Trips sack∾⟨"card"⟩}
  "5. three initials"‿{𝕊: ⟨"Ana"‿"Al", "Bo"‿"Bea", ⟨"Cy"⟩⟩ t.Expect g.ByInitial "Ana"‿"Bo"‿"Al"‿"Cy"‿"Bea"}
  "5. piles in order of first appearance"‿{𝕊: ⟨"Zed"‿"Zoe", ⟨"Amy"⟩⟩ t.Expect g.ByInitial "Zed"‿"Amy"‿"Zoe"}
  "5. every name on its own"‿{𝕊: ⟨⟨"Ana"⟩, ⟨"Bo"⟩⟩ t.Expect g.ByInitial "Ana"‿"Bo"}
⟩
