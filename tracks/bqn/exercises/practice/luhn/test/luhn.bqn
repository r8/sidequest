t ← •Import "../lib/test.bqn"
g ← •Import "../luhn.bqn"

t.Run ⟨
  "single digit strings can not be valid"‿{𝕊: 0 t.Expect g.Valid "1"}
  "a single zero is invalid"‿{𝕊: 0 t.Expect g.Valid "0"}
  "a simple valid SIN that remains valid if reversed"‿{𝕊: 1 t.Expect g.Valid "059"}
  "a simple valid SIN that becomes invalid if reversed"‿{𝕊: 1 t.Expect g.Valid "59"}
  "a valid Canadian SIN"‿{𝕊: 1 t.Expect g.Valid "055 444 285"}
  "invalid Canadian SIN"‿{𝕊: 0 t.Expect g.Valid "055 444 286"}
  "invalid credit card"‿{𝕊: 0 t.Expect g.Valid "8273 1232 7352 0569"}
  "invalid long number with an even remainder"‿{𝕊: 0 t.Expect g.Valid "1 2345 6789 1234 5678 9012"}
  "invalid long number with a remainder divisible by 5"‿{𝕊: 0 t.Expect g.Valid "1 2345 6789 1234 5678 9013"}
  "valid number with an even number of digits"‿{𝕊: 1 t.Expect g.Valid "095 245 88"}
  "valid number with an odd number of spaces"‿{𝕊: 1 t.Expect g.Valid "234 567 891 234"}
  "valid strings with a non-digit added at the end become invalid"‿{𝕊: 0 t.Expect g.Valid "059a"}
  "valid strings with punctuation included become invalid"‿{𝕊: 0 t.Expect g.Valid "055-444-285"}
  "valid strings with symbols included become invalid"‿{𝕊: 0 t.Expect g.Valid "055# 444$ 285"}
  "single zero with space is invalid"‿{𝕊: 0 t.Expect g.Valid " 0"}
  "more than a single zero is valid"‿{𝕊: 1 t.Expect g.Valid "0000 0"}
  "input digit 9 is correctly converted to output digit 9"‿{𝕊: 1 t.Expect g.Valid "091"}
  "very long input is valid"‿{𝕊: 1 t.Expect g.Valid "9999999999 9999999999 9999999999 9999999999"}
  "valid luhn with an odd number of digits and non zero first digit"‿{𝕊: 1 t.Expect g.Valid "109"}
  "using ascii value for non-doubled non-digit isn't allowed"‿{𝕊: 0 t.Expect g.Valid "055b 444 285"}
  "using ascii value for doubled non-digit isn't allowed"‿{𝕊: 0 t.Expect g.Valid ":9"}
  "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed"‿{𝕊: 0 t.Expect g.Valid "59%59"}
⟩
