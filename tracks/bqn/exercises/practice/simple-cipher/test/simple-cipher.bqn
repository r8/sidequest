t ← •Import "../lib/test.bqn"
g ← •Import "../simple-cipher.bqn"

t.Run ⟨
  "Random key cipher > Can encode"‿{𝕊: k ← g.RandomKey @ ⋄ (10↑k) t.Expect k g.Encode "aaaaaaaaaa"}
  "Random key cipher > Can decode"‿{𝕊: k ← g.RandomKey @ ⋄ "aaaaaaaaaa" t.Expect k g.Decode 10↑k}
  "Random key cipher > Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method"‿{𝕊:
    k ← g.RandomKey @
    "abcdefghij" t.Expect k g.Decode k g.Encode "abcdefghij"
  }
  "Random key cipher > Key is made only of lowercase letters"‿{𝕊:
    k ← g.RandomKey @
    1 t.Expect 100 ≤ ≠k
    1 t.Expect ∧´ k ∊ 'a'+↕26
  }
  "Substitution cipher > Can encode"‿{𝕊: "abcdefghij" t.Expect "abcdefghij" g.Encode "aaaaaaaaaa"}
  "Substitution cipher > Can decode"‿{𝕊: "aaaaaaaaaa" t.Expect "abcdefghij" g.Decode "abcdefghij"}
  "Substitution cipher > Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method"‿{𝕊:
    "abcdefghij" t.Expect "abcdefghij" g.Decode "abcdefghij" g.Encode "abcdefghij"
  }
  "Substitution cipher > Can double shift encode"‿{𝕊: "qayaeaagaciai" t.Expect "iamapandabear" g.Encode "iamapandabear"}
  "Substitution cipher > Can wrap on encode"‿{𝕊: "zabcdefghi" t.Expect "abcdefghij" g.Encode "zzzzzzzzzz"}
  "Substitution cipher > Can wrap on decode"‿{𝕊: "zzzzzzzzzz" t.Expect "abcdefghij" g.Decode "zabcdefghi"}
  "Substitution cipher > Can encode messages longer than the key"‿{𝕊: "iboaqcnecbfcr" t.Expect "abc" g.Encode "iamapandabear"}
  "Substitution cipher > Can decode messages longer than the key"‿{𝕊: "iamapandabear" t.Expect "abc" g.Decode "iboaqcnecbfcr"}
⟩
