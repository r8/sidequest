# span LargestProduct digits → the largest product of span adjacent digits in the string digits;
# errors with "span must not be negative", "span must not exceed string length" or "digits input must
# only contain digits"
LargestProduct ⇐ {
  "span must not be negative" ! 𝕨 ≥ 0
  "span must not exceed string length" ! 𝕨 ≤ ≠𝕩
  "digits input must only contain digits" ! ∧´ 𝕩 ∊ '0'+↕10
  ⌈´ ×´˘ 𝕨 ↕ 𝕩-'0'
}
