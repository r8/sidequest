# Clocks are values, not objects: the same time of day must always give the same (≡) clock.
# This one is the number of minutes since midnight.

# Create hour‿minute → a clock; hours and minutes may be out of range or negative, and roll over
Create ⇐ {h‿m: 1440|m+60×h}

# ToString clock → the time as "HH:MM"
ToString ⇐ {1↓∾ ':'⊸∾¨ ¯2↑¨ '0'∾¨ •Fmt¨ (⌊𝕩÷60)‿(60|𝕩)}

# clock Add minutes → the clock that many minutes later
Add ⇐ 1440|+

# clock Subtract minutes → the clock that many minutes earlier
Subtract ⇐ 1440|-
