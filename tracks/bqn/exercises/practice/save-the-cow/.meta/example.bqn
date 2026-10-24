# word Guess guesses → state‿maskedWord‿remainingFailures after guessing each letter of guesses
# in turn, where state is "Ongoing", "Win" or "Lose"; errors with "cannot guess after the game
# is won" or "cannot guess after the game is lost" when a guess comes after the game ended
Guess ⇐ {
  word ← 𝕨
  Step ← {g 𝕊 shown‿failures:
    "cannot guess after the game is won" ! ¬∧´shown
    "cannot guess after the game is lost" ! failures < 10
    hit ← word = g
    ⟨shown ∨ hit, failures + ¬∨´hit ∧ ¬shown⟩
  }
  shown‿failures ← ⟨0¨word, 0⟩ Step´ ⌽𝕩
  state ← (∧´shown) ⊑ ⟨(failures≥10) ⊑ "Ongoing"‿"Lose", "Win"⟩
  ⟨state, '_'¨⌾((¬shown)⊸/) word, 0⌈9-failures⟩
}
