# Attachment _twice x → Attachment applied to x, then to the result
_twice ⇐ {𝔽 𝔽 𝕩}

# First _then_ Second x → Second applied to the result of First applied to x
_then_ ⇐ {𝔾 𝔽 𝕩}

# factor _times amounts → each amount multiplied by factor
_times ⇐ {𝕗 × 𝕩}

# attachments ApplyAll x → the result of each attachment applied to x
ApplyAll ⇐ {x ← 𝕩 ⋄ {𝕏 x}¨ 𝕨}

# Scoop grams → a function that adds grams to its argument
Scoop ⇐ {𝕩⊸+}
