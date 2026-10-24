# Introduction

Repeat, `F⍟n`, applies `F` to its argument `n` times; `F⍟0` returns the argument unchanged.

```bqn
2⊸×⍟3 100         # 800
2⊸×⍟(↕4) 100      # ⟨100, 200, 400, 800⟩: one result per count
2⊸×⍟¯2 800        # 200: a negative count repeats the inverse
2⊸×⍟{𝕩<10} 7      # 14: a function computes the count
```

A list of counts gives a result for every count, which is how to collect each step of a process. A count of
`1` or `0` from a comparison applies `F` only when a condition holds.
