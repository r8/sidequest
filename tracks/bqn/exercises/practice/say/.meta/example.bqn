# Say number → number (0 to 999,999,999,999) in English words;
# errors with "input out of range" otherwise
Say ⇐ {
  (𝕩<0) ∨ 𝕩>999999999999 ? "input out of range" ! 0 ;
  𝕩=0 ? "zero" ;
  groups ← 1000 | ⌊𝕩 ÷ 1e9‿1e6‿1e3‿1
  Words (0<groups) / groups {(Hundreds 𝕨) ∾ 𝕩}¨ " billion"‿" million"‿" thousand"‿""
}

small ← ⟨
  "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"
  "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
⟩
tens ← "" ‿ "" ‿ "twenty" ‿ "thirty" ‿ "forty" ‿ "fifty" ‿ "sixty" ‿ "seventy" ‿ "eighty" ‿ "ninety"

Words ← {1↓∾' '⊸∾¨𝕩}
TwoDigits ← {𝕩<20 ? 𝕩⊑small ; ((⌊𝕩÷10)⊑tens) ∾ (0<10|𝕩) / "-" ∾ (10|𝕩)⊑small}
Hundreds ← {
  h‿r ← (⌊𝕩÷100) ⋈ 100|𝕩
  Words ((0<h) / ⋈(h⊑small)∾" hundred") ∾ (0<r) / ⋈TwoDigits r
}
