# Recite start‿end → the verses from start to end (1-based, inclusive), one line per verse
Recite ⇐ {s‿e: Verse¨ s + ↕1+e-s}

parts ← ⟨
  "house that Jack built.", "malt that lay in", "rat that ate", "cat that killed"
  "dog that worried", "cow with the crumpled horn that tossed", "maiden all forlorn that milked"
  "man all tattered and torn that kissed", "priest all shaven and shorn that married"
  "rooster that crowed in the morn that woke", "farmer sowing his corn that kept"
  "horse and the hound and the horn that belonged to"
⟩
Verse ← {"This is" ∾ ∾" the "⊸∾¨ ⌽𝕩↑parts}
