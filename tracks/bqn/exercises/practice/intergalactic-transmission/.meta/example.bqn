# Messages and transmissions are lists of bytes, as numbers from 0 to 255.

# TransmitSequence message → the transmitted bytes: the message bits, 7 at a time (the last group
# padded with 0 bits), each followed by a parity bit that makes the number of 1 bits even
TransmitSequence ⇐ {
  data ← ∘‿7 ⥊ (7×⌈7÷˜≠b)↑b ← ⥊Bits 𝕩
  FromBits data ∾˘ 2|+´˘data
}

# DecodeMessage transmission → the message bytes, dropping the padding bits at the end; errors with
# "wrong parity" if any byte has an odd number of 1 bits
DecodeMessage ⇐ {
  "wrong parity" ! ∧´ 0=2|+´˘ b ← Bits 𝕩
  FromBits ∘‿8 ⥊ (8×⌊8÷˜≠d)↑d ← ⥊ ¯1↓˘b
}

Bits ← {2|⌊𝕩÷⌜2⋆⌽↕8}              # bytes → a table of their bits, most significant first
FromBits ← {+´˘ 𝕩 ×⎉1 2⋆⌽↕8}      # table of 8-bit rows → bytes
