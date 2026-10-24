t ← •Import "../lib/test.bqn"
g ← •Import "../matching-brackets.bqn"

t.Run ⟨
  "paired square brackets"‿{𝕊: 1 t.Expect g.IsPaired "[]"}
  "empty string"‿{𝕊: 1 t.Expect g.IsPaired ""}
  "unpaired brackets"‿{𝕊: 0 t.Expect g.IsPaired "[["}
  "wrong ordered brackets"‿{𝕊: 0 t.Expect g.IsPaired "}{"}
  "wrong closing bracket"‿{𝕊: 0 t.Expect g.IsPaired "{]"}
  "paired with whitespace"‿{𝕊: 1 t.Expect g.IsPaired "{ }"}
  "partially paired brackets"‿{𝕊: 0 t.Expect g.IsPaired "{[])"}
  "simple nested brackets"‿{𝕊: 1 t.Expect g.IsPaired "{[]}"}
  "several paired brackets"‿{𝕊: 1 t.Expect g.IsPaired "{}[]"}
  "paired and nested brackets"‿{𝕊: 1 t.Expect g.IsPaired "([{}({}[])])"}
  "unopened closing brackets"‿{𝕊: 0 t.Expect g.IsPaired "{[)][]}"}
  "unpaired and nested brackets"‿{𝕊: 0 t.Expect g.IsPaired "([{])"}
  "paired and wrong nested brackets"‿{𝕊: 0 t.Expect g.IsPaired "[({]})"}
  "paired and wrong nested brackets but innermost are correct"‿{𝕊: 0 t.Expect g.IsPaired "[({}])"}
  "paired and incomplete brackets"‿{𝕊: 0 t.Expect g.IsPaired "{}["}
  "too many closing brackets"‿{𝕊: 0 t.Expect g.IsPaired "[]]"}
  "early unexpected brackets"‿{𝕊: 0 t.Expect g.IsPaired ")()"}
  "early mismatched brackets"‿{𝕊: 0 t.Expect g.IsPaired "{)()"}
  "math expression"‿{𝕊: 1 t.Expect g.IsPaired "(((185 + 223.85) * 15) - 543)/2"}
  "complex latex expression"‿{𝕊: 1 t.Expect g.IsPaired "\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)"}
⟩
