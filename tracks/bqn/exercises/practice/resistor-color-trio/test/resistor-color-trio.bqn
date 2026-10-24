t ← •Import "../lib/test.bqn"
g ← •Import "../resistor-color-trio.bqn"

t.Run ⟨
  "Orange and orange and black"‿{𝕊: 33‿"ohms" t.Expect g.Label "orange"‿"orange"‿"black"}
  "Blue and grey and brown"‿{𝕊: 680‿"ohms" t.Expect g.Label "blue"‿"grey"‿"brown"}
  "Red and black and red"‿{𝕊: 2‿"kiloohms" t.Expect g.Label "red"‿"black"‿"red"}
  "Green and brown and orange"‿{𝕊: 51‿"kiloohms" t.Expect g.Label "green"‿"brown"‿"orange"}
  "Yellow and violet and yellow"‿{𝕊: 470‿"kiloohms" t.Expect g.Label "yellow"‿"violet"‿"yellow"}
  "Blue and violet and blue"‿{𝕊: 67‿"megaohms" t.Expect g.Label "blue"‿"violet"‿"blue"}
  "Minimum possible value"‿{𝕊: 0‿"ohms" t.Expect g.Label "black"‿"black"‿"black"}
  "Maximum possible value"‿{𝕊: 99‿"gigaohms" t.Expect g.Label "white"‿"white"‿"white"}
  "First two colors make an invalid octal number"‿{𝕊: 8‿"ohms" t.Expect g.Label "black"‿"grey"‿"black"}
  "Ignore extra colors"‿{𝕊: 650‿"kiloohms" t.Expect g.Label "blue"‿"green"‿"yellow"‿"orange"}
⟩
