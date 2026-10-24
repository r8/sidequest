# Introduction

_Replicate_ `/` copies each element of its right argument as many times as the matching number on its left. With
a boolean _mask_ of `1`s and `0`s, that keeps or drops each element, which is how BQN filters:

```bqn
days ← 3‿12‿40‿8
(days > 10) / days     # ⟨12, 40⟩
2‿0‿1 / "abc"          # "aac"
```

The left argument must have the same length as the list, or be a single number that applies to every element.

With one argument, `/` gives _indices_: the positions of the `1`s in a mask, counting from `0`, or each index
repeated by its count.

```bqn
/ 0‿1‿1‿0              # ⟨1, 2⟩
/ 2‿0‿1                # ⟨0, 0, 2⟩
```
