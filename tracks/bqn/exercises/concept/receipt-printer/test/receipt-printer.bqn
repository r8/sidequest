t ← •Import "../lib/test.bqn"
g ← •Import "../receipt-printer.bqn"

t.Run ⟨
  "1. three apples"‿{𝕊: "3 x Apples" t.Expect 3 g.Quantity "Apples"}
  "1. a single loaf"‿{𝕊: "1 x Bread" t.Expect 1 g.Quantity "Bread"}
  "1. a big order"‿{𝕊: "120 x Nails" t.Expect 120 g.Quantity "Nails"}
  "2. euros and cents"‿{𝕊: "12.05" t.Expect g.Cents 1205}
  "2. only cents"‿{𝕊: "0.05" t.Expect g.Cents 5}
  "2. under a euro"‿{𝕊: "0.99" t.Expect g.Cents 99}
  "2. free"‿{𝕊: "0.00" t.Expect g.Cents 0}
  "2. a large amount"‿{𝕊: "1234.50" t.Expect g.Cents 123450}
  "3. pad a price"‿{𝕊: "  4.50" t.Expect 6 g.PadLeft "4.50"}
  "3. already wide enough"‿{𝕊: "12.05" t.Expect 5 g.PadLeft "12.05"}
  "3. pad an empty text"‿{𝕊: "   " t.Expect 3 g.PadLeft ""}
  "4. apples"‿{𝕊: "Apples          4.50" t.Expect "Apples" g.Line 450}
  "4. a long name and a high price"‿{𝕊: "Olive oil 1L   12.99" t.Expect "Olive oil 1L" g.Line 1299}
  "4. a cheap item"‿{𝕊: "Gum             0.40" t.Expect "Gum" g.Line 40}
  "5. euros and cents"‿{𝕊: 1205 t.Expect g.ParsePrice "12.05"}
  "5. a price that rounds badly"‿{𝕊: 29 t.Expect g.ParsePrice "0.29"}
  "5. a whole number"‿{𝕊: 300 t.Expect g.ParsePrice "3"}
  "5. one decimal"‿{𝕊: 750 t.Expect g.ParsePrice "7.5"}
⟩
