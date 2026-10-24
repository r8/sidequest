# Each function takes the list of scores, oldest first, and leaves it unchanged.
# Scores scores → the list of scores
Scores ⇐ ⊢
# Latest scores → the last score added
Latest ⇐ ⊢´
# PersonalBest scores → the highest score
PersonalBest ⇐ ⌈´
# PersonalTopThree scores → the three highest scores, highest first (fewer if there are fewer scores)
PersonalTopThree ⇐ (3⌊≠)⊸↑∨
