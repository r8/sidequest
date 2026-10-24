t ← •Import "../lib/test.bqn"
g ← •Import "../roman-numerals.bqn"

t.Run ⟨
  "1 is I"‿{𝕊: "I" t.Expect g.Roman 1}
  "2 is II"‿{𝕊: "II" t.Expect g.Roman 2}
  "3 is III"‿{𝕊: "III" t.Expect g.Roman 3}
  "4 is IV"‿{𝕊: "IV" t.Expect g.Roman 4}
  "5 is V"‿{𝕊: "V" t.Expect g.Roman 5}
  "6 is VI"‿{𝕊: "VI" t.Expect g.Roman 6}
  "9 is IX"‿{𝕊: "IX" t.Expect g.Roman 9}
  "16 is XVI"‿{𝕊: "XVI" t.Expect g.Roman 16}
  "27 is XXVII"‿{𝕊: "XXVII" t.Expect g.Roman 27}
  "48 is XLVIII"‿{𝕊: "XLVIII" t.Expect g.Roman 48}
  "49 is XLIX"‿{𝕊: "XLIX" t.Expect g.Roman 49}
  "59 is LIX"‿{𝕊: "LIX" t.Expect g.Roman 59}
  "66 is LXVI"‿{𝕊: "LXVI" t.Expect g.Roman 66}
  "93 is XCIII"‿{𝕊: "XCIII" t.Expect g.Roman 93}
  "141 is CXLI"‿{𝕊: "CXLI" t.Expect g.Roman 141}
  "163 is CLXIII"‿{𝕊: "CLXIII" t.Expect g.Roman 163}
  "166 is CLXVI"‿{𝕊: "CLXVI" t.Expect g.Roman 166}
  "402 is CDII"‿{𝕊: "CDII" t.Expect g.Roman 402}
  "575 is DLXXV"‿{𝕊: "DLXXV" t.Expect g.Roman 575}
  "666 is DCLXVI"‿{𝕊: "DCLXVI" t.Expect g.Roman 666}
  "911 is CMXI"‿{𝕊: "CMXI" t.Expect g.Roman 911}
  "1024 is MXXIV"‿{𝕊: "MXXIV" t.Expect g.Roman 1024}
  "1666 is MDCLXVI"‿{𝕊: "MDCLXVI" t.Expect g.Roman 1666}
  "3000 is MMM"‿{𝕊: "MMM" t.Expect g.Roman 3000}
  "3001 is MMMI"‿{𝕊: "MMMI" t.Expect g.Roman 3001}
  "3888 is MMMDCCCLXXXVIII"‿{𝕊: "MMMDCCCLXXXVIII" t.Expect g.Roman 3888}
  "3999 is MMMCMXCIX"‿{𝕊: "MMMCMXCIX" t.Expect g.Roman 3999}
⟩
