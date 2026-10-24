# Recite start‿end → the verses from start to end (1-based, inclusive), one line per verse
Recite ⇐ {s‿e: Verse¨ s + ↕1+e-s}

days ← ⟨"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"⟩
gifts ← ⟨
  "a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens", "four Calling Birds"
  "five Gold Rings", "six Geese-a-Laying", "seven Swans-a-Swimming", "eight Maids-a-Milking"
  "nine Ladies Dancing", "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"
⟩
Verse ← {
  given ← (∾ (⌽1↓𝕩↑gifts) ∾¨ <", ") ∾ ((𝕩>1)/"and ") ∾ ⊑gifts
  "On the " ∾ ((𝕩-1)⊑days) ∾ " day of Christmas my true love gave to me: " ∾ given ∾ "."
}
