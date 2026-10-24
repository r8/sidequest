# Add moment → the moment one gigasecond (10⁹ s) later; moments are "YYYY-MM-DDTHH:MM:SS"
# strings, and a date-only "YYYY-MM-DD" means midnight
digits ← '0'+↕10

# Days since 1970-01-01 of a proleptic Gregorian date, and back (Howard Hinnant's algorithms):
# the year is shifted to start in March, so the leap day falls at its end.
Days ← {y‿m‿d:
  y -↩ m≤2
  era ← ⌊y÷400 ⋄ yoe ← y-400×era
  doy ← (d-1) + ⌊5÷˜2+153×12|m-3
  (146097×era) + doy + (365×yoe) + (-´⌊yoe÷4‿100) - 719468
}
Civil ← {
  era ← ⌊146097÷˜𝕩+719468 ⋄ doe ← 𝕩+719468-146097×era
  yoe ← ⌊365÷˜doe - -´⌊doe÷1460‿36524‿146096
  doy ← doe - (365×yoe) + -´⌊yoe÷4‿100
  mp ← ⌊153÷˜2+5×doy
  m ← 1+12|mp+2
  ⟨(400×era)+yoe+m≤2, m, 1+doy-⌊5÷˜2+153×mp⟩
}

Pad ← {(-𝕨)↑(𝕨⥊'0')∾•Fmt 𝕩}

Add ⇐ {
  d ← 𝕩∊digits
  n ← 6↑ •ParseFloat¨ (¯1+d×1++`¬d) ⊔ 𝕩
  s ← 1e9 + (86400×Days 3↑n) + +´3600‿60‿1×3↓n
  date ← 1↓∾ '-'⊸∾¨ 4‿2‿2 Pad¨ Civil ⌊s÷86400
  time ← 1↓∾ ':'⊸∾¨ 2 Pad¨ 60|⌊(86400|s)÷3600‿60‿1
  date∾"T"∾time
}
