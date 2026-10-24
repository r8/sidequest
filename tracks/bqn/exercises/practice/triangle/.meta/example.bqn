# The sides are a list a‿b‿c. A triangle needs every side positive and the sum of any two sides
# at least the third; otherwise every function returns 0.
Valid ← (∧´0<⊢) ∧ +´ ≥ 2×⌈´

# Equilateral sides → 1 if all three sides are equal, else 0
Equilateral ⇐ Valid ∧ 1 = ≠∘⍷

# Isosceles sides → 1 if at least two sides are equal, else 0
Isosceles ⇐ Valid ∧ 3 > ≠∘⍷

# Scalene sides → 1 if all three sides differ, else 0
Scalene ⇐ Valid ∧ 3 = ≠∘⍷
