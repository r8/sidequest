# CanChain dominoes → 1 if the dominoes (a list of pairs) form a closed chain using every one, else 0
# A closed chain is an Eulerian circuit: every number appears an even number of times, and the
# dominoes all connect.
CanChain ⇐ {
  0=≠𝕩 ? 1 ;
  e ← (v ← ⍷∾𝕩)⊸⊐¨ 𝕩
  adj ← ∨´ {∧⌜˜(↕≠v)∊𝕩}¨ e
  reach ← {𝕩 ∨˝∘∧⎉1‿∞ 𝕩}⍟(≠v) adj
  (∧´¬2|/⁼∾e) ∧ ∧´⊏reach
}
