t ← •Import "../lib/test.bqn"
g ← •Import "../armstrong-numbers.bqn"

# The 33- and 39-digit Armstrong numbers exceed 2⋆53, beyond exact doubles, so they are left out.
t.Run ⟨
  "Zero is an Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 0}
  "Single-digit numbers are Armstrong numbers"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 5}
  "There are no two-digit Armstrong numbers"‿{𝕊: 0 t.Expect g.IsArmstrongNumber 10}
  "Three-digit number that is an Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 153}
  "Three-digit number that is not an Armstrong number"‿{𝕊: 0 t.Expect g.IsArmstrongNumber 100}
  "Four-digit number that is an Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 9474}
  "Four-digit number that is not an Armstrong number"‿{𝕊: 0 t.Expect g.IsArmstrongNumber 9475}
  "Seven-digit number that is an Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 9926315}
  "Seven-digit number that is not an Armstrong number"‿{𝕊: 0 t.Expect g.IsArmstrongNumber 9926314}
  # Not in the canonical data: the 16-digit Armstrong numbers are below 2⋆53, so exact.
  "Sixteen-digit number that is an Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 4338281769391370}
  "Another sixteen-digit Armstrong number"‿{𝕊: 1 t.Expect g.IsArmstrongNumber 4338281769391371}
⟩
