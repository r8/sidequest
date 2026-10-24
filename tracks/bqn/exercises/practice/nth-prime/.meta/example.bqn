# Sieve of Eratosthenes: the primes up to n.
Sieve ← {n←𝕩
  Strike ← {p←𝕨 ⋄ p⊑𝕩 ? 0¨⌾(((p×p)+p×↕1+⌊(n-p×p)÷p)⊸⊏) 𝕩 ; 𝕩}
  / (2≤↕1+n) Strike´ ⌽2+↕0⌈¯1+⌊√n
}

# Prime n → the nth prime number, counting 2 as the first;
# errors with "there is no zeroth prime" when n is 0
# The nth prime is below n×(ln n + ln ln n) for n ≥ 6, and below 15 before that.
Prime ⇐ {
  𝕩 < 1 ? "there is no zeroth prime" ! 0 ;
  (𝕩-1) ⊑ Sieve 15 ⌈ ⌈ 𝕩 × +⟜(⋆⁼) ⋆⁼ 3⌈𝕩
}
