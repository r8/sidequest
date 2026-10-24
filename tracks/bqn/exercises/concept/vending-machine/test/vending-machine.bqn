t ← •Import "../lib/test.bqn"
g ← •Import "../vending-machine.bqn"

products ← "cola"‿"chips"‿"gum"‿"water"
prices ← 150‿120‿90‿200‿175‿60

t.Run ⟨
  "1. the second slot"‿{𝕊: "chips" t.Expect 1 g.Product products}
  "1. the first slot"‿{𝕊: "cola" t.Expect 0 g.Product products}
  "1. the last slot"‿{𝕊: "water" t.Expect 3 g.Product products}
  "2. an order with a repeat"‿{𝕊: "gum"‿"cola"‿"gum" t.Expect 2‿0‿2 g.Order products}
  "2. a single item"‿{𝕊: ⟨"water"⟩ t.Expect ⟨3⟩ g.Order products}
  "2. an empty order"‿{𝕊: ⟨⟩ t.Expect ⟨⟩ g.Order products}
  "3. four products"‿{𝕊: "water" t.Expect g.Newest products}
  "3. one product"‿{𝕊: "tea" t.Expect g.Newest ⟨"tea"⟩}
  "4. the first slot"‿{𝕊: 150 t.Expect prices g.PriceOf "A1"}
  "4. the end of the first row"‿{𝕊: 90 t.Expect prices g.PriceOf "A3"}
  "4. the second row"‿{𝕊: 175 t.Expect prices g.PriceOf "B2"}
  "4. a third row"‿{𝕊: 8 t.Expect (↕9) g.PriceOf "C3"}
  "5. from the start"‿{𝕊: "VENDING " t.Expect "VENDING MACHINE " g.Window 0}
  "5. in the middle"‿{𝕊: "MACHINE " t.Expect "VENDING MACHINE " g.Window 8}
  "5. wrapping around"‿{𝕊: "O HELLO " t.Expect "HELLO " g.Window 4}
  "5. a start past the end"‿{𝕊: "ELLO HEL" t.Expect "HELLO " g.Window 7}
⟩
