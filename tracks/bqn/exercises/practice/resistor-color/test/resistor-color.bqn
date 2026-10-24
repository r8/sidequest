t ← •Import "../lib/test.bqn"
g ← •Import "../resistor-color.bqn"

t.Run ⟨
  "Color codes > Black"‿{𝕊: 0 t.Expect g.ColorCode "black"}
  "Color codes > White"‿{𝕊: 9 t.Expect g.ColorCode "white"}
  "Color codes > Orange"‿{𝕊: 3 t.Expect g.ColorCode "orange"}
  "Colors"‿{𝕊: "black"‿"brown"‿"red"‿"orange"‿"yellow"‿"green"‿"blue"‿"violet"‿"grey"‿"white" t.Expect g.Colors @}
⟩
