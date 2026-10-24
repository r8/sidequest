# mask BlackOut text → text with each character where mask is 1 replaced by '█'
BlackOut ⇐ {'█'¨⌾(𝕨⊸/) 𝕩}

# HideDigits text → text with every digit replaced by '#'
HideDigits ⇐ {'#'¨⌾((('0'≤𝕩)∧𝕩≤'9')⊸/) 𝕩}

# indices Capitalise text → text with the lowercase letters at indices made capitals
Capitalise ⇐ {-⟜32⌾(𝕨⊸⊏) 𝕩}

# Declassify file → file with its first element (the level) lowered by one, but not below 0
Declassify ⇐ (0⌈-⟜1)⌾⊑

# RoundBudget amounts → each amount rounded down to a multiple of 100
RoundBudget ⇐ ⌊⌾(÷⟜100)
