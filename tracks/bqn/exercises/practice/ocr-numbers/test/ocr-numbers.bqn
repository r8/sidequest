t ← •Import "../lib/test.bqn"
g ← •Import "../ocr-numbers.bqn"

onesAndZeros ← ⟨
  "       _     _        _  _ "
  "  |  || |  || |  |  || || |"
  "  |  ||_|  ||_|  |  ||_||_|"
  "                           "
⟩

garbled ← ⟨
  "       _     _           _ "
  "  |  || |  || |     || || |"
  "  |  | _|  ||_|  |  ||_||_|"
  "                           "
⟩

allDigits ← ⟨
  "    _  _     _  _  _  _  _  _ "
  "  | _| _||_||_ |_   ||_||_|| |"
  "  ||_  _|  | _||_|  ||_| _||_|"
  "                              "
⟩

threeLines ← ⟨
  "    _  _ "
  "  | _| _|"
  "  ||_  _|"
  "         "
  "    _  _ "
  "|_||_ |_ "
  "  | _||_|"
  "         "
  " _  _  _ "
  "  ||_||_|"
  "  ||_| _|"
  "         "
⟩

t.Run ⟨
  "Recognizes 0"‿{𝕊: "0" t.Expect g.Convert ⟨" _ ", "| |", "|_|", "   "⟩}
  "Recognizes 1"‿{𝕊: "1" t.Expect g.Convert ⟨"   ", "  |", "  |", "   "⟩}
  "Unreadable but correctly sized inputs return ?"‿{𝕊: "?" t.Expect g.Convert ⟨"   ", "  _", "  |", "   "⟩}
  "Input with a number of lines that is not a multiple of four raises an error"‿{𝕊: {𝕊: g.Convert ⟨" _ ", "| |", "   "⟩} t._throws "Number of input lines is not a multiple of four"}
  "Input with a number of columns that is not a multiple of three raises an error"‿{𝕊: {𝕊: g.Convert ⟨"    ", "   |", "   |", "    "⟩} t._throws "Number of input columns is not a multiple of three"}
  "Recognizes 110101100"‿{𝕊: "110101100" t.Expect g.Convert onesAndZeros}
  "Garbled numbers in a string are replaced with ?"‿{𝕊: "11?10?1?0" t.Expect g.Convert garbled}
  "Recognizes 2"‿{𝕊: "2" t.Expect g.Convert ⟨" _ ", " _|", "|_ ", "   "⟩}
  "Recognizes 3"‿{𝕊: "3" t.Expect g.Convert ⟨" _ ", " _|", " _|", "   "⟩}
  "Recognizes 4"‿{𝕊: "4" t.Expect g.Convert ⟨"   ", "|_|", "  |", "   "⟩}
  "Recognizes 5"‿{𝕊: "5" t.Expect g.Convert ⟨" _ ", "|_ ", " _|", "   "⟩}
  "Recognizes 6"‿{𝕊: "6" t.Expect g.Convert ⟨" _ ", "|_ ", "|_|", "   "⟩}
  "Recognizes 7"‿{𝕊: "7" t.Expect g.Convert ⟨" _ ", "  |", "  |", "   "⟩}
  "Recognizes 8"‿{𝕊: "8" t.Expect g.Convert ⟨" _ ", "|_|", "|_|", "   "⟩}
  "Recognizes 9"‿{𝕊: "9" t.Expect g.Convert ⟨" _ ", "|_|", " _|", "   "⟩}
  "Recognizes string of decimal numbers"‿{𝕊: "1234567890" t.Expect g.Convert allDigits}
  "Numbers separated by empty lines are recognized. Lines are joined by commas."‿{𝕊: "123,456,789" t.Expect g.Convert threeLines}
⟩
