Double ← 2⊸×

# hours Grow count → the count after doubling once an hour for that many hours
Grow ⇐ {Double⍟𝕨 𝕩}

# hours Timeline count → the counts at hour 0, 1, … up to hours
Timeline ⇐ {Double⍟(↕1+𝕨) 𝕩}

# hours Earlier count → the count that many hours ago
Earlier ⇐ {Double⍟(-𝕨) 𝕩}

# count HoursNeeded target → the hours of doubling it takes count to reach target
HoursNeeded ⇐ {2 ⋆⁼ 𝕩 ÷ 𝕨}

# Encode celsius → the display code: 3 × (celsius + 10)
Encode ⇐ 3⊸×∘(10⊸+)

# Decode code → the temperature in Celsius the display code stands for
Decode ⇐ Encode⁼
