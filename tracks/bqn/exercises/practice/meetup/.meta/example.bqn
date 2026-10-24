# Meetup year‿month‿week‿weekday → the meetup date as "YYYY-MM-DD"; week is "first", "second",
# "third", "fourth", "last" or "teenth" (the 13th to the 19th), weekday "Monday" … "Sunday"
weekdays ← "Sunday"‿"Monday"‿"Tuesday"‿"Wednesday"‿"Thursday"‿"Friday"‿"Saturday"
weeks ← "first"‿"second"‿"third"‿"fourth"‿"last"‿"teenth"

# Days since 1970-01-01 (a Thursday), with the year shifted to start in March.
Days ← {y‿m‿d:
  y -↩ m≤2
  era ← ⌊y÷400 ⋄ yoe ← y-400×era
  (146097×era) + (d-1) + (⌊5÷˜2+153×12|m-3) + (365×yoe) + (-´⌊yoe÷4‿100) - 719468
}
Leap ← {≠´0=4‿100‿400|𝕩}
Pad ← {(-𝕨)↑(𝕨⥊'0')∾•Fmt 𝕩}

Meetup ⇐ {y‿m‿w‿wd:
  ds ← 1+↕(m-1)⊑31‿(28+Leap y)‿31‿30‿31‿30‿31‿31‿30‿31‿30‿31
  ds /˜↩ (⊑weekdays⊐<wd) = 7|4+Days y‿m‿ds
  ds /˜↩ ds ≥ 13×"teenth"≡w
  d ← ((⊑weeks⊐<w)⊑0‿1‿2‿3‿¯1‿0) ⊑ ds
  1↓∾ '-'⊸∾¨ 4‿2‿2 Pad¨ y‿m‿d
}
