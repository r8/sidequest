t ← •Import "../lib/test.bqn"
g ← •Import "../house.bqn"

multipleVerses ← ⟨
  "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
⟩

fullRhyme ← ⟨
  "This is the house that Jack built."
  "This is the malt that lay in the house that Jack built."
  "This is the rat that ate the malt that lay in the house that Jack built."
  "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
  "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
⟩

t.Run ⟨
  "verse one - the house that jack built"‿{𝕊: ⟨"This is the house that Jack built."⟩ t.Expect g.Recite 1‿1}
  "verse two - the malt that lay"‿{𝕊: ⟨"This is the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 2‿2}
  "verse three - the rat that ate"‿{𝕊: ⟨"This is the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 3‿3}
  "verse four - the cat that killed"‿{𝕊: ⟨"This is the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 4‿4}
  "verse five - the dog that worried"‿{𝕊: ⟨"This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 5‿5}
  "verse six - the cow with the crumpled horn"‿{𝕊: ⟨"This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 6‿6}
  "verse seven - the maiden all forlorn"‿{𝕊: ⟨"This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 7‿7}
  "verse eight - the man all tattered and torn"‿{𝕊: ⟨"This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 8‿8}
  "verse nine - the priest all shaven and shorn"‿{𝕊: ⟨"This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 9‿9}
  "verse 10 - the rooster that crowed in the morn"‿{𝕊: ⟨"This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 10‿10}
  "verse 11 - the farmer sowing his corn"‿{𝕊: ⟨"This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 11‿11}
  "verse 12 - the horse and the hound and the horn"‿{𝕊: ⟨"This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."⟩ t.Expect g.Recite 12‿12}
  "multiple verses"‿{𝕊: multipleVerses t.Expect g.Recite 4‿8}
  "full rhyme"‿{𝕊: fullRhyme t.Expect g.Recite 1‿12}
⟩
