# Evaluate lines → the stack (bottom first) after running every line of Forth; a definition
# ": name words… ;" takes a whole line. Errors: "empty stack", "only one value on the stack",
# "divide by zero", "undefined operation", "illegal operation".
digits ← '0'+↕10
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}
ws ← " " ∾ @+9+↕5
Words ← (¬-˜⊢×·+`»⊸>)∘(¬∊⟜ws)⊔⊢
IsNum ← {d ← ('-'=⊑𝕩)↓𝕩 ⋄ (×≠d) ∧ ∧´d∊digits}

# The built-in words, how many values each takes off the stack, and what it puts back.
ops ← "+"‿"-"‿"*"‿"/"‿"dup"‿"drop"‿"swap"‿"over"
arity ← 2‿2‿2‿2‿1‿1‿2‿2
fns ← ⟨
  {a‿b: ⋈a+b}, {a‿b: ⋈a-b}, {a‿b: ⋈a×b}
  {a‿b: "divide by zero" ! b≠0 ⋄ ⋈(×q)×⌊|q←a÷b}
  {𝕩∾𝕩}, {0↑𝕩}, ⌽, {𝕩∾⊏𝕩}
⟩

# word Step stack → the stack after one number or built-in word
Step ← {
  1=•Type 𝕨 ? 𝕩∾𝕨 ;
  i ← ⊑ops⊐<𝕨 ⋄ n ← i⊑arity
  ((1⌊≠𝕩)⊑"empty stack"‿"only one value on the stack") ! n ≤ ≠𝕩
  ((-n)↓𝕩) ∾ (i⊑fns){𝔽𝕩} (-n)↑𝕩
}

Evaluate ⇐ {
  names ← defs ← stack ← ⟨⟩
  # A word expands to numbers and built-ins. Definitions are expanded when made, so redefining
  # a word later doesn't change the words already defined with it.
  Expand ← {
    i ← ⊑names⊐<𝕩
    i < ≠names ? i⊑defs ;
    IsNum 𝕩 ? ⋈•ParseFloat 𝕩 ;
    ⊑(<𝕩)∊ops ? ⋈𝕩 ;
    "undefined operation" ! 0
  }
  Define ← {
    "illegal operation" ! ¬IsNum ⊑𝕩
    body ← ∾Expand¨ 1↓𝕩
    names ∾˜↩ <⊑𝕩 ⋄ defs ∾˜↩ <body
  }
  Line ← {0=≠𝕩 ? @ ; ":"≡⊑𝕩 ? Define 1↓¯1↓𝕩 ; stack Step´↩ ⌽∾Expand¨𝕩}
  Line∘Words∘Lower¨ 𝕩
  stack
}
