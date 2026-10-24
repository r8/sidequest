# Introduction

Combinators are modifiers that build a function out of other functions:

| combinator | one argument | two arguments |
| --- | --- | --- |
| `F∘G` atop | `F G x` | `F (w G x)` |
| `F○G` over | `F G x` | `(G w) F (G x)` |
| `F⊸G` before | `(F x) G x` | `(F w) G x` |
| `F⟜G` after | `x F (G x)` | `w F (G x)` |
| `F˜` self, swap | `x F x` | `x F w` |
| `⊢` / `⊣` identity | `x` | `x` / `w` |

A subject used as an operand is a constant function, so `⊸` and `⟜` bind a value to one side of a function:
`2⊸×` doubles, `-⟜32` subtracts 32. Bound functions chain with `∘`:

```bqn
ToFahrenheit ← 32⊸+∘(1.8⊸×)
ToFahrenheit 100    # 212
```
