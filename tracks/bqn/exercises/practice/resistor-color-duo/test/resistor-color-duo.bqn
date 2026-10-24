t ← •Import "../lib/test.bqn"
g ← •Import "../resistor-color-duo.bqn"

t.Run ⟨
  "Brown and black"‿{𝕊: 10 t.Expect g.Value "brown"‿"black"}
  "Blue and grey"‿{𝕊: 68 t.Expect g.Value "blue"‿"grey"}
  "Yellow and violet"‿{𝕊: 47 t.Expect g.Value "yellow"‿"violet"}
  "White and red"‿{𝕊: 92 t.Expect g.Value "white"‿"red"}
  "Orange and orange"‿{𝕊: 33 t.Expect g.Value "orange"‿"orange"}
  "Ignore additional colors"‿{𝕊: 51 t.Expect g.Value "green"‿"brown"‿"orange"}
  "Black and brown, one-digit"‿{𝕊: 1 t.Expect g.Value "black"‿"brown"}
⟩
