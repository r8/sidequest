# SortedTimes times → the times from smallest to largest
SortedTimes ⇐ {∧ 𝕩}

# Alphabetical names → the names in alphabetical order
Alphabetical ⇐ {∧ 𝕩}

# names Finishers times → the names from fastest to slowest, ties in listed order
Finishers ⇐ {(⍋ 𝕩) ⊏ 𝕨}

# names Winner times → the name of the fastest runner, the first listed on a tie
Winner ⇐ {(⊑ ⍋ 𝕩) ⊑ 𝕨}

# Places times → each runner's place, 1 for the fastest, in listed order
Places ⇐ {1 + ⍋ ⍋ 𝕩}

# names Leaderboard points → the names from most to fewest points, ties in listed order
Leaderboard ⇐ {(⍒ 𝕩) ⊏ 𝕨}
