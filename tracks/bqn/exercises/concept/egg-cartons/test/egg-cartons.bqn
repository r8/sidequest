t ← •Import "../lib/test.bqn"
g ← •Import "../egg-cartons.bqn"

belt ← 61‿58‿63‿60‿59‿62‿64‿57‿60‿61‿58‿63
carton ← > ⟨61‿58‿63‿60‿59‿62, 64‿57‿60‿61‿58‿63⟩
counting ← > ⟨1‿2‿3‿4‿5‿6, 7‿8‿9‿10‿11‿12⟩
crate ← > ⟨carton, counting⟩

t.Run ⟨
  "1. a carton from the belt"‿{𝕊: carton t.Expect g.Carton belt}
  "1. the first row is filled first"‿{𝕊: counting t.Expect g.Carton 1+↕12}
  "1. a carton is a table"‿{𝕊: 2‿6 t.Expect ≢ g.Carton belt}
  "2. the shape of a carton"‿{𝕊: 2‿6 t.Expect g.Dimensions carton}
  "2. the shape of a crate"‿{𝕊: 2‿2‿6 t.Expect g.Dimensions crate}
  "2. the shape of a single row"‿{𝕊: ⟨6⟩ t.Expect g.Dimensions 61‿58‿63‿60‿59‿62}
  "3. a carton holds twelve"‿{𝕊: 12 t.Expect g.EggCount carton}
  "3. a crate of two cartons"‿{𝕊: 24 t.Expect g.EggCount crate}
  "3. a tray of three rows of four"‿{𝕊: 12 t.Expect g.EggCount > 3⥊<60‿61‿62‿63}
  "3. a single row"‿{𝕊: 5 t.Expect g.EggCount 1‿2‿3‿4‿5}
  "4. unpack a carton"‿{𝕊: belt t.Expect g.Unpack carton}
  "4. unpack a crate"‿{𝕊: (belt∾1+↕12) t.Expect g.Unpack crate}
  "4. unpack a single row"‿{𝕊: 1‿2‿3 t.Expect g.Unpack 1‿2‿3}
  "5. turn a carton"‿{𝕊: (> ⟨1‿7, 2‿8, 3‿9, 4‿10, 5‿11, 6‿12⟩) t.Expect g.Turn counting}
  "5. a turned carton has six rows"‿{𝕊: 6‿2 t.Expect ≢ g.Turn carton}
  "5. turning twice gives the carton back"‿{𝕊: carton t.Expect g.Turn g.Turn carton}
  "6. a crate of two cartons"‿{𝕊: crate t.Expect 2 g.Crate belt∾1+↕12}
  "6. a crate of one carton"‿{𝕊: (>⟨counting⟩) t.Expect 1 g.Crate 1+↕12}
  "6. a crate of five cartons"‿{𝕊: 5‿2‿6 t.Expect ≢ 5 g.Crate ↕60}
⟩
