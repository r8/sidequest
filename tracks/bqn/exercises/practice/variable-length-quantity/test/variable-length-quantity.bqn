t ← •Import "../lib/test.bqn"
g ← •Import "../variable-length-quantity.bqn"

t.Run ⟨
  "Encode a series of integers, producing a series of bytes. > zero"‿{𝕊: ⟨0⟩ t.Expect g.Encode ⟨0⟩}
  "Encode a series of integers, producing a series of bytes. > arbitrary single byte"‿{𝕊: ⟨64⟩ t.Expect g.Encode ⟨64⟩}
  "Encode a series of integers, producing a series of bytes. > asymmetric single byte"‿{𝕊: ⟨83⟩ t.Expect g.Encode ⟨83⟩}
  "Encode a series of integers, producing a series of bytes. > largest single byte"‿{𝕊: ⟨127⟩ t.Expect g.Encode ⟨127⟩}
  "Encode a series of integers, producing a series of bytes. > smallest double byte"‿{𝕊: ⟨129, 0⟩ t.Expect g.Encode ⟨128⟩}
  "Encode a series of integers, producing a series of bytes. > arbitrary double byte"‿{𝕊: ⟨192, 0⟩ t.Expect g.Encode ⟨8192⟩}
  "Encode a series of integers, producing a series of bytes. > asymmetric double byte"‿{𝕊: ⟨129, 45⟩ t.Expect g.Encode ⟨173⟩}
  "Encode a series of integers, producing a series of bytes. > largest double byte"‿{𝕊: ⟨255, 127⟩ t.Expect g.Encode ⟨16383⟩}
  "Encode a series of integers, producing a series of bytes. > smallest triple byte"‿{𝕊: ⟨129, 128, 0⟩ t.Expect g.Encode ⟨16384⟩}
  "Encode a series of integers, producing a series of bytes. > arbitrary triple byte"‿{𝕊: ⟨192, 128, 0⟩ t.Expect g.Encode ⟨1048576⟩}
  "Encode a series of integers, producing a series of bytes. > asymmetric triple byte"‿{𝕊: ⟨135, 171, 28⟩ t.Expect g.Encode ⟨120220⟩}
  "Encode a series of integers, producing a series of bytes. > largest triple byte"‿{𝕊: ⟨255, 255, 127⟩ t.Expect g.Encode ⟨2097151⟩}
  "Encode a series of integers, producing a series of bytes. > smallest quadruple byte"‿{𝕊: ⟨129, 128, 128, 0⟩ t.Expect g.Encode ⟨2097152⟩}
  "Encode a series of integers, producing a series of bytes. > arbitrary quadruple byte"‿{𝕊: ⟨192, 128, 128, 0⟩ t.Expect g.Encode ⟨134217728⟩}
  "Encode a series of integers, producing a series of bytes. > asymmetric quadruple byte"‿{𝕊: ⟨129, 213, 238, 4⟩ t.Expect g.Encode ⟨3503876⟩}
  "Encode a series of integers, producing a series of bytes. > largest quadruple byte"‿{𝕊: ⟨255, 255, 255, 127⟩ t.Expect g.Encode ⟨268435455⟩}
  "Encode a series of integers, producing a series of bytes. > smallest quintuple byte"‿{𝕊: ⟨129, 128, 128, 128, 0⟩ t.Expect g.Encode ⟨268435456⟩}
  "Encode a series of integers, producing a series of bytes. > arbitrary quintuple byte"‿{𝕊: ⟨143, 248, 128, 128, 0⟩ t.Expect g.Encode ⟨4278190080⟩}
  "Encode a series of integers, producing a series of bytes. > asymmetric quintuple byte"‿{𝕊: ⟨136, 179, 149, 194, 5⟩ t.Expect g.Encode ⟨2254790917⟩}
  "Encode a series of integers, producing a series of bytes. > maximum 32-bit integer input"‿{𝕊: ⟨143, 255, 255, 255, 127⟩ t.Expect g.Encode ⟨4294967295⟩}
  "Encode a series of integers, producing a series of bytes. > two single-byte values"‿{𝕊: ⟨64, 127⟩ t.Expect g.Encode ⟨64, 127⟩}
  "Encode a series of integers, producing a series of bytes. > two multi-byte values"‿{𝕊: ⟨129, 128, 0, 200, 232, 86⟩ t.Expect g.Encode ⟨16384, 1193046⟩}
  "Encode a series of integers, producing a series of bytes. > many multi-byte values"‿{𝕊: ⟨192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0⟩ t.Expect g.Encode ⟨8192, 1193046, 268435455, 0, 16383, 16384⟩}
  "Decode a series of bytes, producing a series of integers. > one byte"‿{𝕊: ⟨127⟩ t.Expect g.Decode ⟨127⟩}
  "Decode a series of bytes, producing a series of integers. > two bytes"‿{𝕊: ⟨8192⟩ t.Expect g.Decode ⟨192, 0⟩}
  "Decode a series of bytes, producing a series of integers. > three bytes"‿{𝕊: ⟨2097151⟩ t.Expect g.Decode ⟨255, 255, 127⟩}
  "Decode a series of bytes, producing a series of integers. > four bytes"‿{𝕊: ⟨2097152⟩ t.Expect g.Decode ⟨129, 128, 128, 0⟩}
  "Decode a series of bytes, producing a series of integers. > maximum 32-bit integer"‿{𝕊: ⟨4294967295⟩ t.Expect g.Decode ⟨143, 255, 255, 255, 127⟩}
  "Decode a series of bytes, producing a series of integers. > incomplete sequence causes error"‿{𝕊: {𝕊: g.Decode ⟨255⟩} t._throws "incomplete sequence"}
  "Decode a series of bytes, producing a series of integers. > incomplete sequence causes error, even if value is zero"‿{𝕊: {𝕊: g.Decode ⟨128⟩} t._throws "incomplete sequence"}
  "Decode a series of bytes, producing a series of integers. > multiple values"‿{𝕊: ⟨8192, 1193046, 268435455, 0, 16383, 16384⟩ t.Expect g.Decode ⟨192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0⟩}
⟩
