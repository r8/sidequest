t ← •Import "../lib/test.bqn"
g ← •Import "../pig-latin.bqn"

t.Run ⟨
  "ay is added to words that start with vowels > word beginning with a"‿{𝕊: "appleay" t.Expect g.Translate "apple"}
  "ay is added to words that start with vowels > word beginning with e"‿{𝕊: "earay" t.Expect g.Translate "ear"}
  "ay is added to words that start with vowels > word beginning with i"‿{𝕊: "iglooay" t.Expect g.Translate "igloo"}
  "ay is added to words that start with vowels > word beginning with o"‿{𝕊: "objectay" t.Expect g.Translate "object"}
  "ay is added to words that start with vowels > word beginning with u"‿{𝕊: "underay" t.Expect g.Translate "under"}
  "ay is added to words that start with vowels > word beginning with a vowel and followed by a qu"‿{𝕊: "equalay" t.Expect g.Translate "equal"}
  "first letter and ay are moved to the end of words that start with consonants > word beginning with p"‿{𝕊: "igpay" t.Expect g.Translate "pig"}
  "first letter and ay are moved to the end of words that start with consonants > word beginning with k"‿{𝕊: "oalakay" t.Expect g.Translate "koala"}
  "first letter and ay are moved to the end of words that start with consonants > word beginning with x"‿{𝕊: "enonxay" t.Expect g.Translate "xenon"}
  "first letter and ay are moved to the end of words that start with consonants > word beginning with q without a following u"‿{𝕊: "atqay" t.Expect g.Translate "qat"}
  "first letter and ay are moved to the end of words that start with consonants > word beginning with consonant and vowel containing qu"‿{𝕊: "iquidlay" t.Expect g.Translate "liquid"}
  "some letter clusters are treated like a single consonant > word beginning with ch"‿{𝕊: "airchay" t.Expect g.Translate "chair"}
  "some letter clusters are treated like a single consonant > word beginning with qu"‿{𝕊: "eenquay" t.Expect g.Translate "queen"}
  "some letter clusters are treated like a single consonant > word beginning with qu and a preceding consonant"‿{𝕊: "aresquay" t.Expect g.Translate "square"}
  "some letter clusters are treated like a single consonant > word beginning with th"‿{𝕊: "erapythay" t.Expect g.Translate "therapy"}
  "some letter clusters are treated like a single consonant > word beginning with thr"‿{𝕊: "ushthray" t.Expect g.Translate "thrush"}
  "some letter clusters are treated like a single consonant > word beginning with sch"‿{𝕊: "oolschay" t.Expect g.Translate "school"}
  "some letter clusters are treated like a single vowel > word beginning with yt"‿{𝕊: "yttriaay" t.Expect g.Translate "yttria"}
  "some letter clusters are treated like a single vowel > word beginning with xr"‿{𝕊: "xrayay" t.Expect g.Translate "xray"}
  "position of y in a word determines if it is a consonant or a vowel > y is treated like a consonant at the beginning of a word"‿{𝕊: "ellowyay" t.Expect g.Translate "yellow"}
  "position of y in a word determines if it is a consonant or a vowel > y is treated like a vowel at the end of a consonant cluster"‿{𝕊: "ythmrhay" t.Expect g.Translate "rhythm"}
  "position of y in a word determines if it is a consonant or a vowel > y as second letter in two letter word"‿{𝕊: "ymay" t.Expect g.Translate "my"}
  "phrases are translated > a whole phrase"‿{𝕊: "ickquay astfay unray" t.Expect g.Translate "quick fast run"}
  # Not in the canonical data: words are separated by any whitespace, which the translation keeps.
  "spacing between words is kept"‿{𝕊: ("ymay  ogday"∾(@+9)∾"ickquay") t.Expect g.Translate "my  dog"∾(@+9)∾"quick"}
⟩
