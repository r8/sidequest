# Transform legacy → each lowercase letter‿score pair, sorted by letter. legacy is a list of
# score‿letters pairs, the letters being uppercase one-letter strings: ⟨1‿⟨"A", "E"⟩, 2‿⟨"D"⟩⟩
Lower ← +⟜(32×('A'⊸≤∧≤⟜'Z'))
Transform ⇐ {∧ ∾ {s‿l: ⋈⟜s∘Lower¨ l}¨ 𝕩}
