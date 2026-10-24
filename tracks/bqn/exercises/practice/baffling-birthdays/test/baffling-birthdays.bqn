t ← •Import "../lib/test.bqn"
g ← •Import "../baffling-birthdays.bqn"

# The random cases check many samples, so a correct solution fails them only with negligible
# probability.
Year‿Month‿Day ← {•ParseFloat 𝕩⊸⊏}¨ ⟨↕4, 5+↕2, 8+↕2⟩
Leap ← ≠˝0=4‿100‿400|⌜⊢
# Passes when the estimate 𝕩 is within 3 percentage points of 𝕨; otherwise reports the nearest bound.
Near ← {((𝕨-3)⌈(𝕨+3)⌊𝕩) t.Expect 𝕩}

t.Run ⟨
  "shared birthday > one birthdate"‿{𝕊: 0 t.Expect g.SharedBirthday ⟨"2000-01-01"⟩}
  "shared birthday > two birthdates with same year, month, and day"‿{𝕊: 1 t.Expect g.SharedBirthday "2000-01-01"‿"2000-01-01"}
  "shared birthday > two birthdates with same year and month, but different day"‿{𝕊: 0 t.Expect g.SharedBirthday "2012-05-09"‿"2012-05-17"}
  "shared birthday > two birthdates with same month and day, but different year"‿{𝕊: 1 t.Expect g.SharedBirthday "1999-10-23"‿"1988-10-23"}
  "shared birthday > two birthdates with same year, but different month and day"‿{𝕊: 0 t.Expect g.SharedBirthday "2007-12-19"‿"2007-04-27"}
  "shared birthday > two birthdates with different year, month, and day"‿{𝕊: 0 t.Expect g.SharedBirthday "1997-08-04"‿"1963-11-23"}
  "shared birthday > multiple birthdates without shared birthday"‿{𝕊: 0 t.Expect g.SharedBirthday "1966-07-29"‿"1977-02-12"‿"2001-12-25"‿"1980-11-10"}
  "shared birthday > multiple birthdates with one shared birthday"‿{𝕊: 1 t.Expect g.SharedBirthday "1966-07-29"‿"1977-02-12"‿"2001-07-29"‿"1980-11-10"}
  "shared birthday > multiple birthdates with more than one shared birthday"‿{𝕊: 1 t.Expect g.SharedBirthday "1966-07-29"‿"1977-02-12"‿"2001-12-25"‿"1980-07-29"‿"2019-02-12"}
  "random birthdates > generate requested number of birthdates"‿{𝕊: n ← 0‿1‿2‿10‿23‿70‿365 ⋄ n t.Expect ≠∘g.RandomBirthdates¨ n}
  "random birthdates > years are not leap years"‿{𝕊: ⟨⟩ t.Expect (Leap Year¨)⊸/ g.RandomBirthdates 1000}
  "random birthdates > months are random"‿{𝕊: (1+↕12) t.Expect ∧⍷ Month¨ g.RandomBirthdates 2000}
  "random birthdates > days are random"‿{𝕊: (1+↕31) t.Expect ∧⍷ Day¨ g.RandomBirthdates 2000}
  "estimated probability of at least one shared birthday > for one person"‿{𝕊: 0 Near g.EstimatedProbabilityOfSharedBirthday 1}
  "estimated probability of at least one shared birthday > among ten people"‿{𝕊: 11.694818 Near g.EstimatedProbabilityOfSharedBirthday 10}
  "estimated probability of at least one shared birthday > among twenty-three people"‿{𝕊: 50.729723 Near g.EstimatedProbabilityOfSharedBirthday 23}
  "estimated probability of at least one shared birthday > among seventy people"‿{𝕊: 99.915958 Near g.EstimatedProbabilityOfSharedBirthday 70}
⟩
