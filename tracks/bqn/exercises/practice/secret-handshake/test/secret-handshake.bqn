t ← •Import "../lib/test.bqn"
g ← •Import "../secret-handshake.bqn"

t.Run ⟨
  "wink for 1"‿{𝕊: ⟨"wink"⟩ t.Expect g.Commands 1}
  "double blink for 10"‿{𝕊: ⟨"double blink"⟩ t.Expect g.Commands 2}
  "close your eyes for 100"‿{𝕊: ⟨"close your eyes"⟩ t.Expect g.Commands 4}
  "jump for 1000"‿{𝕊: ⟨"jump"⟩ t.Expect g.Commands 8}
  "combine two actions"‿{𝕊: "wink"‿"double blink" t.Expect g.Commands 3}
  "reverse two actions"‿{𝕊: "double blink"‿"wink" t.Expect g.Commands 19}
  "reversing one action gives the same action"‿{𝕊: ⟨"jump"⟩ t.Expect g.Commands 24}
  "reversing no actions still gives no actions"‿{𝕊: ⟨⟩ t.Expect g.Commands 16}
  "all possible actions"‿{𝕊: "wink"‿"double blink"‿"close your eyes"‿"jump" t.Expect g.Commands 15}
  "reverse all possible actions"‿{𝕊: "jump"‿"close your eyes"‿"double blink"‿"wink" t.Expect g.Commands 31}
  "do nothing for zero"‿{𝕊: ⟨⟩ t.Expect g.Commands 0}
⟩
