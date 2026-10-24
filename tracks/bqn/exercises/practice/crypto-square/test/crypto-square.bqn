t ← •Import "../lib/test.bqn"
g ← •Import "../crypto-square.bqn"

t.Run ⟨
  "empty plaintext results in an empty ciphertext"‿{𝕊: "" t.Expect g.Ciphertext ""}
  "normalization results in empty plaintext"‿{𝕊: "" t.Expect g.Ciphertext "... --- ..."}
  "Lowercase"‿{𝕊: "a" t.Expect g.Ciphertext "A"}
  "Remove spaces"‿{𝕊: "b" t.Expect g.Ciphertext "  b "}
  "Remove punctuation"‿{𝕊: "1" t.Expect g.Ciphertext "@1,%!"}
  "9 character plaintext results in 3 chunks of 3 characters"‿{𝕊: "tsf hiu isn" t.Expect g.Ciphertext "This is fun!"}
  "8 character plaintext results in 3 chunks, the last one with a trailing space"‿{𝕊: "clu hlt io " t.Expect g.Ciphertext "Chill out."}
  "54 character plaintext results in 8 chunks, the last two with trailing spaces"‿{𝕊:
    "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau " t.Expect g.Ciphertext "If man was meant to stay on the ground, god would have given us roots."
  }
⟩
