t ← •Import "../lib/test.bqn"
g ← •Import "../acronym.bqn"

t.Run ⟨
  "basic"‿{𝕊: "PNG" t.Expect g.Abbreviate "Portable Network Graphics"}
  "lowercase words"‿{𝕊: "ROR" t.Expect g.Abbreviate "Ruby on Rails"}
  "punctuation"‿{𝕊: "FIFO" t.Expect g.Abbreviate "First In, First Out"}
  "all caps word"‿{𝕊: "GIMP" t.Expect g.Abbreviate "GNU Image Manipulation Program"}
  "punctuation without whitespace"‿{𝕊: "CMOS" t.Expect g.Abbreviate "Complementary metal-oxide semiconductor"}
  "very long abbreviation"‿{𝕊: "ROTFLSHTMDCOALM" t.Expect g.Abbreviate "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"}
  "consecutive delimiters"‿{𝕊: "SIMUFTA" t.Expect g.Abbreviate "Something - I made up from thin air"}
  "apostrophes"‿{𝕊: "HC" t.Expect g.Abbreviate "Halley's Comet"}
  "underscore emphasis"‿{𝕊: "TRNT" t.Expect g.Abbreviate "The Road _Not_ Taken"}
  # Not in the canonical data: whitespace other than the space separates words too.
  "words separated by tabs and newlines"‿{𝕊: "PNG" t.Expect g.Abbreviate "Portable"∾(@+9)∾"Network"∾(@+10)∾"Graphics"}
⟩
