# Keys and texts are lower-case letters only; the key repeats when the text is longer.
_shift ← {'a' + 26 | (𝕩-'a') 𝔽 (≠𝕩) ⥊ 𝕨-'a'}

# Encode: key Encode plaintext → each letter shifted forward by the matching key letter (a=0, b=1, …)
Encode ⇐ + _shift

# Decode: key Decode ciphertext → each letter shifted back by the matching key letter
Decode ⇐ - _shift

# RandomKey @ → a random key of at least 100 lower-case letters
RandomKey ⇐ {𝕊: 'a' + 100 •rand.Range 26}
