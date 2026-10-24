# Primes limit → the primes up to and including limit, in ascending order
# Start with 2…limit marked; each still-marked p up to √limit unmarks p×p, p×p+p, … .
Primes ⇐ {n←𝕩
  Strike ← {p←𝕨 ⋄ p⊑𝕩 ? 0¨⌾(((p×p)+p×↕1+⌊(n-p×p)÷p)⊸⊏) 𝕩 ; 𝕩}
  / (2≤↕1+n) Strike´ ⌽2+↕0⌈¯1+⌊√n
}
