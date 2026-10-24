# Introduction

Undo, `F⁼`, is the inverse of `F`: the function that takes `F`'s result back to its argument.

```bqn
2⊸×⁼ 10          # 5
√⁼ 3             # 9
2 ⋆⁼ 16          # 4: with two arguments, which y gives 2 ⋆ y = 16
```

BQN inverts arithmetic, bound functions and compositions of them, so a conversion written as
`3⊸×∘(10⊸+)` can be reversed with `⁼`. Blocks are not inverted, and functions that lose information, like `⌊`,
have no inverse.
