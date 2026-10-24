t ← •Import "../lib/test.bqn"
g ← •Import "../raindrops.bqn"

t.Run ⟨
  "the sound for 1 is 1"‿{𝕊: "1" t.Expect g.Convert 1}
  "the sound for 3 is Pling"‿{𝕊: "Pling" t.Expect g.Convert 3}
  "the sound for 5 is Plang"‿{𝕊: "Plang" t.Expect g.Convert 5}
  "the sound for 7 is Plong"‿{𝕊: "Plong" t.Expect g.Convert 7}
  "the sound for 6 is Pling as it has a factor 3"‿{𝕊: "Pling" t.Expect g.Convert 6}
  "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base"‿{𝕊: "8" t.Expect g.Convert 8}
  "the sound for 9 is Pling as it has a factor 3"‿{𝕊: "Pling" t.Expect g.Convert 9}
  "the sound for 10 is Plang as it has a factor 5"‿{𝕊: "Plang" t.Expect g.Convert 10}
  "the sound for 14 is Plong as it has a factor of 7"‿{𝕊: "Plong" t.Expect g.Convert 14}
  "the sound for 15 is PlingPlang as it has factors 3 and 5"‿{𝕊: "PlingPlang" t.Expect g.Convert 15}
  "the sound for 21 is PlingPlong as it has factors 3 and 7"‿{𝕊: "PlingPlong" t.Expect g.Convert 21}
  "the sound for 25 is Plang as it has a factor 5"‿{𝕊: "Plang" t.Expect g.Convert 25}
  "the sound for 27 is Pling as it has a factor 3"‿{𝕊: "Pling" t.Expect g.Convert 27}
  "the sound for 35 is PlangPlong as it has factors 5 and 7"‿{𝕊: "PlangPlong" t.Expect g.Convert 35}
  "the sound for 49 is Plong as it has a factor 7"‿{𝕊: "Plong" t.Expect g.Convert 49}
  "the sound for 52 is 52"‿{𝕊: "52" t.Expect g.Convert 52}
  "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7"‿{𝕊: "PlingPlangPlong" t.Expect g.Convert 105}
  "the sound for 3125 is Plang as it has a factor 5"‿{𝕊: "Plang" t.Expect g.Convert 3125}
  # Not in the canonical data: numbers from 10⋆15 up are still written out digit by digit.
  "the sound for 1000000000000004 is 1000000000000004"‿{𝕊: "1000000000000004" t.Expect g.Convert 1000000000000004}
⟩
