t ← •Import "../lib/test.bqn"
g ← •Import "../scrabble-score.bqn"

t.Run ⟨
  "lowercase letter"‿{𝕊: 1 t.Expect g.Score "a"}
  "uppercase letter"‿{𝕊: 1 t.Expect g.Score "A"}
  "valuable letter"‿{𝕊: 4 t.Expect g.Score "f"}
  "short word"‿{𝕊: 2 t.Expect g.Score "at"}
  "short, valuable word"‿{𝕊: 12 t.Expect g.Score "zoo"}
  "medium word"‿{𝕊: 6 t.Expect g.Score "street"}
  "medium, valuable word"‿{𝕊: 22 t.Expect g.Score "quirky"}
  "long, mixed-case word"‿{𝕊: 41 t.Expect g.Score "OxyphenButazone"}
  "english-like word"‿{𝕊: 8 t.Expect g.Score "pinata"}
  "empty input"‿{𝕊: 0 t.Expect g.Score ""}
  "entire alphabet available"‿{𝕊: 87 t.Expect g.Score "abcdefghijklmnopqrstuvwxyz"}
⟩
