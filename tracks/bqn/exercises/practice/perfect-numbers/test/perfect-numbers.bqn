t ← •Import "../lib/test.bqn"
g ← •Import "../perfect-numbers.bqn"

t.Run ⟨
  "Perfect numbers > Smallest perfect number is classified correctly"‿{𝕊: "perfect" t.Expect g.Classify 6}
  "Perfect numbers > Medium perfect number is classified correctly"‿{𝕊: "perfect" t.Expect g.Classify 28}
  "Perfect numbers > Large perfect number is classified correctly"‿{𝕊: "perfect" t.Expect g.Classify 33550336}
  "Abundant numbers > Smallest abundant number is classified correctly"‿{𝕊: "abundant" t.Expect g.Classify 12}
  "Abundant numbers > Medium abundant number is classified correctly"‿{𝕊: "abundant" t.Expect g.Classify 30}
  "Abundant numbers > Large abundant number is classified correctly"‿{𝕊: "abundant" t.Expect g.Classify 33550335}
  "Abundant numbers > Perfect square abundant number is classified correctly"‿{𝕊: "abundant" t.Expect g.Classify 196}
  "Deficient numbers > Smallest prime deficient number is classified correctly"‿{𝕊: "deficient" t.Expect g.Classify 2}
  "Deficient numbers > Smallest non-prime deficient number is classified correctly"‿{𝕊: "deficient" t.Expect g.Classify 4}
  "Deficient numbers > Medium deficient number is classified correctly"‿{𝕊: "deficient" t.Expect g.Classify 32}
  "Deficient numbers > Large deficient number is classified correctly"‿{𝕊: "deficient" t.Expect g.Classify 33550337}
  "Deficient numbers > Edge case (no factors other than itself) is classified correctly"‿{𝕊: "deficient" t.Expect g.Classify 1}
  "Invalid inputs > Zero is rejected (as it is not a positive integer)"‿{𝕊: {𝕊: g.Classify 0} t._throws "Classification is only possible for positive integers."}
  "Invalid inputs > Negative integer is rejected (as it is not a positive integer)"‿{𝕊: {𝕊: g.Classify ¯1} t._throws "Classification is only possible for positive integers."}
⟩
