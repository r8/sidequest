# Clean phrase → the ten-digit NANP number as a string, without the country code 1; errors with
# "letters not permitted", "punctuations not permitted", "must not be fewer than 10 digits",
# "must not be greater than 11 digits", "11 digits must start with 1",
# "area code cannot start with zero" / "… with one", or "exchange code cannot start with zero" /
# "… with one", checked in that order
digits ← '0'+↕10
letters ← ('a'+↕26)∾'A'+↕26

messages ← ⟨
  "letters not permitted", "punctuations not permitted"
  "must not be fewer than 10 digits", "must not be greater than 11 digits", "11 digits must start with 1"
  "area code cannot start with zero", "area code cannot start with one"
  "exchange code cannot start with zero", "exchange code cannot start with one"
⟩

# Raises the message of the first failed check, if any.
Fail ← {∨´𝕩 ? (⊑𝕩/messages) ! 0 ; @}

Clean ⇐ {
  d ← (𝕩∊digits)/𝕩
  n ← ≠d
  number ← ¯10↑(10⥊' ')∾d
  Fail ⟨
    ∨´𝕩∊letters, ¬∧´𝕩∊digits∾" ()-.+"
    n<10, n>11, (n=11)∧'1'≠⊑d∾'1'
    '0'=0⊑number, '1'=0⊑number
    '0'=3⊑number, '1'=3⊑number
  ⟩
  number
}
