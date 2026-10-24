t ← •Import "../lib/test.bqn"
g ← •Import "../paint-mixer.bqn"

t.Run ⟨
  "1. two bases, three tints"‿{𝕊: (> ⟨23‿25‿28, 28‿30‿33⟩) t.Expect 20‿25 g.Prices 3‿5‿8}
  "1. one base"‿{𝕊: (> ⟨⟨14, 19⟩⟩) t.Expect ⟨12⟩ g.Prices 2‿7}
  "1. a row per base, a column per tint"‿{𝕊: 4‿2 t.Expect ≢ 10‿11‿12‿13 g.Prices 1‿2}
  "1. no tints yet"‿{𝕊: 2‿0 t.Expect ≢ 20‿25 g.Prices ⟨⟩}
  "2. two sizes, two paints"‿{𝕊: (> ⟨8‿12, 20‿30⟩) t.Expect 1‿2.5 g.Costs 8‿12}
  "2. three sizes, one paint"‿{𝕊: (> ⟨⟨5⟩, ⟨10⟩, ⟨25⟩⟩) t.Expect 1‿2‿5 g.Costs ⟨5⟩}
  "2. a row per size, a column per paint"‿{𝕊: 2‿3 t.Expect ≢ 1‿4 g.Costs 9‿10‿11}
  "3. two shades, three colours"‿{𝕊: (> ⟨"pale blue"‿"pale red"‿"pale green", "deep blue"‿"deep red"‿"deep green"⟩) t.Expect "pale"‿"deep" g.MixNames "blue"‿"red"‿"green"}
  "3. one shade, two colours"‿{𝕊: (> ⟨⟨"dusty pink", "dusty grey"⟩⟩) t.Expect ⟨"dusty"⟩ g.MixNames "pink"‿"grey"}
  "3. three shades, one colour"‿{𝕊: (> ⟨"light teal"⟩‿⟨"mid teal"⟩‿⟨"dark teal"⟩) t.Expect "light"‿"mid"‿"dark" g.MixNames ⟨"teal"⟩}
  "4. three tins, three orders"‿{𝕊: (> ⟨0‿1‿1, 0‿0‿0, 1‿0‿0⟩) t.Expect "RGB" g.Matches "BRR"}
  "4. every tin matches"‿{𝕊: (2‿2 ⥊ 1) t.Expect "WW" g.Matches "WW"}
  "4. a row per tin, a column per order"‿{𝕊: 4‿1 t.Expect ≢ "RGBY" g.Matches "Y"}
⟩
