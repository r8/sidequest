t ← •Import "../lib/test.bqn"
g ← •Import "../say.bqn"

t.Run ⟨
  "zero"‿{𝕊: "zero" t.Expect g.Say 0}
  "one"‿{𝕊: "one" t.Expect g.Say 1}
  "fourteen"‿{𝕊: "fourteen" t.Expect g.Say 14}
  "twenty"‿{𝕊: "twenty" t.Expect g.Say 20}
  "twenty-two"‿{𝕊: "twenty-two" t.Expect g.Say 22}
  "thirty"‿{𝕊: "thirty" t.Expect g.Say 30}
  "ninety-nine"‿{𝕊: "ninety-nine" t.Expect g.Say 99}
  "one hundred"‿{𝕊: "one hundred" t.Expect g.Say 100}
  "one hundred twenty-three"‿{𝕊: "one hundred twenty-three" t.Expect g.Say 123}
  "two hundred"‿{𝕊: "two hundred" t.Expect g.Say 200}
  "nine hundred ninety-nine"‿{𝕊: "nine hundred ninety-nine" t.Expect g.Say 999}
  "one thousand"‿{𝕊: "one thousand" t.Expect g.Say 1000}
  "one thousand two hundred thirty-four"‿{𝕊: "one thousand two hundred thirty-four" t.Expect g.Say 1234}
  "one million"‿{𝕊: "one million" t.Expect g.Say 1000000}
  "one million two thousand three hundred forty-five"‿{𝕊: "one million two thousand three hundred forty-five" t.Expect g.Say 1002345}
  "one billion"‿{𝕊: "one billion" t.Expect g.Say 1000000000}
  "a big number"‿{𝕊: "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three" t.Expect g.Say 987654321123}
  "numbers below zero are out of range"‿{𝕊: {𝕊: g.Say ¯1} t._throws "input out of range"}
  "numbers above 999,999,999,999 are out of range"‿{𝕊: {𝕊: g.Say 1000000000000} t._throws "input out of range"}
⟩
