# Birthdates are "YYYY-MM-DD" strings; a birthday is just the month and day.
Digits ← {'0' + 10 | ⌊𝕩 ÷ 10⋆⌽↕𝕨}              # 𝕨 decimal digits of 𝕩
years ← (¬·≠˝0=4‿100‿400|⌜⊢)⊸/ 1900+↕200        # the non-leap years 1900–2099
days ← 31‿28‿31‿30‿31‿30‿31‿31‿30‿31‿30‿31
birthdays ← ∾ {m‿n: {∾⟨2 Digits m, "-", 2 Digits 𝕩⟩}¨ 1+↕n}¨ (1+↕12) ⋈¨ days   # "01-01" … "12-31"
# SharedBirthday birthdates → 1 if any two of them have the same birthday, else 0
SharedBirthday ⇐ {∨´ ¬∊ 5↓¨𝕩}
# RandomBirthdates n → a list of n random birthdates, all in non-leap years, every birthday equally likely
RandomBirthdates ⇐ {
  y ← 4 Digits¨ years ⊏˜ 𝕩 •rand.Range ≠years
  y ∾¨ '-' ∾¨ birthdays ⊏˜ 𝕩 •rand.Range 365
}
# EstimatedProbabilityOfSharedBirthday n → the estimated chance, as a percentage from 0 to 100,
# that some two of n people share a birthday
trials ← 10000
EstimatedProbabilityOfSharedBirthday ⇐ {100 × trials ÷˜ +´ SharedBirthday∘RandomBirthdates¨ trials⥊𝕩}
