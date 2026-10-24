# Introduction

BQN's booleans are the numbers `1` (true) and `0` (false). The comparisons `=`, `≠`, `<`, `>`, `≤` and `≥`
return them:

```bqn
3 < 5      # 1
3 = 5      # 0
```

`∧` (and), `∨` (or) and `¬` (not) combine booleans. They are arithmetic in disguise (`∧` is `×`, `¬` is
`1-𝕩`), so booleans can also be added to count conditions, or multiplied with an amount to keep or zero it.

Comparisons follow the right-to-left rule, so parenthesise every condition but the last:
`(1 ≤ x) ∧ x ≤ 10`. To test that two booleans differ, use `≠`.
