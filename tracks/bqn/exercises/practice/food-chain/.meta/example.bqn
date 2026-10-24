# Recite start‿end → the lines of verses start to end (1-based, inclusive), with an empty line
# between verses
Recite ⇐ {s‿e: 1↓∾ (⋈"")⊸∾¨ Verse¨ s + ↕1+e-s}

animals ← "fly"‿"spider"‿"bird"‿"cat"‿"dog"‿"goat"‿"cow"‿"horse"
wriggle ← "wriggled and jiggled and tickled inside her"
remarks ← ⟨
  "", "It "∾wriggle∾".", "How absurd to swallow a bird!", "Imagine that, to swallow a cat!"
  "What a hog, to swallow a dog!", "Just opened her throat and swallowed a goat!"
  "I don't know how she swallowed a cow!", "She's dead, of course!"
⟩
# Each animal as named when it is caught: the spider comes with its description.
caught ← ∾⟜(" that "∾wriggle)⌾(1⊸⊑) animals

Verse ← {
  open ← ⟨"I know an old lady who swallowed a "∾((𝕩-1)⊑animals)∾"."⟩ ∾ (0<≠¨)⊸/ ⋈(𝕩-1)⊑remarks
  chain ← {"She swallowed the "∾((𝕩+1)⊑animals)∾" to catch the "∾(𝕩⊑caught)∾"."}¨ ⌽↕𝕩-1
  # The last animal ends the song before the chain.
  open ∾ (𝕩 < ≠animals) / chain ∾ ⟨"I don't know why she swallowed the fly. Perhaps she'll die."⟩
}
