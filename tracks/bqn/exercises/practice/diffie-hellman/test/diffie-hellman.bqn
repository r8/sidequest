t ← •Import "../lib/test.bqn"
g ← •Import "../diffie-hellman.bqn"

t.Run ⟨
  "private key is greater than 1 and less than p"‿{𝕊: 1 t.Expect ∧´∾ {𝕊 p: (1<k)∧p>k ← g.PrivateKey¨ 100⥊p}¨ ⟨5, 7, 23, 7919⟩}
  "private key is random"‿{𝕊: 1 t.Expect 10 < ≠⍷ g.PrivateKey¨ 100⥊7919}
  "can calculate public key using private key"‿{𝕊: 8 t.Expect g.PublicKey 23‿5‿6}
  "can calculate public key when given a different private key"‿{𝕊: 19 t.Expect g.PublicKey 23‿5‿15}
  "can calculate secret using other party's public key"‿{𝕊: 2 t.Expect g.Secret 23‿19‿6}
  "key exchange"‿{𝕊:
    p‿gen ← 23‿5
    a‿b ← g.PrivateKey¨ p‿p
    pubA‿pubB ← {g.PublicKey p‿gen‿𝕩}¨ a‿b
    (g.Secret p‿pubB‿a) t.Expect g.Secret p‿pubA‿b
  }
⟩
