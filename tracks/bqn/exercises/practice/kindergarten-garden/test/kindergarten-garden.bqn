t ← •Import "../lib/test.bqn"
g ← •Import "../kindergarten-garden.bqn"

nl ← @+10
full ← "VRCGVVRVCGGCCGVRGCVCGCGV"∾nl∾"VRCCCGCRRGVCGCRVVCVGCGCV"

t.Run ⟨
  "partial garden > garden with single student"‿{𝕊: "radishes"‿"clover"‿"grass"‿"grass" t.Expect ("RC"∾nl∾"GG") g.Plants "Alice"}
  "partial garden > different garden with single student"‿{𝕊: "violets"‿"clover"‿"radishes"‿"clover" t.Expect ("VC"∾nl∾"RC") g.Plants "Alice"}
  "partial garden > garden with two students"‿{𝕊: "clover"‿"grass"‿"radishes"‿"clover" t.Expect ("VVCG"∾nl∾"VVRC") g.Plants "Bob"}
  "partial garden > multiple students for the same garden with three students > second student's garden"‿{𝕊: "clover"‿"clover"‿"clover"‿"clover" t.Expect ("VVCCGG"∾nl∾"VVCCGG") g.Plants "Bob"}
  "partial garden > multiple students for the same garden with three students > third student's garden"‿{𝕊: "grass"‿"grass"‿"grass"‿"grass" t.Expect ("VVCCGG"∾nl∾"VVCCGG") g.Plants "Charlie"}
  "full garden > for Alice, first student's garden"‿{𝕊: "violets"‿"radishes"‿"violets"‿"radishes" t.Expect full g.Plants "Alice"}
  "full garden > for Bob, second student's garden"‿{𝕊: "clover"‿"grass"‿"clover"‿"clover" t.Expect full g.Plants "Bob"}
  "full garden > for Charlie"‿{𝕊: "violets"‿"violets"‿"clover"‿"grass" t.Expect full g.Plants "Charlie"}
  "full garden > for David"‿{𝕊: "radishes"‿"violets"‿"clover"‿"radishes" t.Expect full g.Plants "David"}
  "full garden > for Eve"‿{𝕊: "clover"‿"grass"‿"radishes"‿"grass" t.Expect full g.Plants "Eve"}
  "full garden > for Fred"‿{𝕊: "grass"‿"clover"‿"violets"‿"clover" t.Expect full g.Plants "Fred"}
  "full garden > for Ginny"‿{𝕊: "clover"‿"grass"‿"grass"‿"clover" t.Expect full g.Plants "Ginny"}
  "full garden > for Harriet"‿{𝕊: "violets"‿"radishes"‿"radishes"‿"violets" t.Expect full g.Plants "Harriet"}
  "full garden > for Ileana"‿{𝕊: "grass"‿"clover"‿"violets"‿"clover" t.Expect full g.Plants "Ileana"}
  "full garden > for Joseph"‿{𝕊: "violets"‿"clover"‿"violets"‿"grass" t.Expect full g.Plants "Joseph"}
  "full garden > for Kincaid, second to last student's garden"‿{𝕊: "grass"‿"clover"‿"clover"‿"grass" t.Expect full g.Plants "Kincaid"}
  "full garden > for Larry, last student's garden"‿{𝕊: "grass"‿"violets"‿"clover"‿"violets" t.Expect full g.Plants "Larry"}
⟩
