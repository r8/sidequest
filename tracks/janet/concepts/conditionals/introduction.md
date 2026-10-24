# Introduction

`if` takes a condition, a then-branch and an optional else-branch, and returns the value of the branch that ran (`nil` when the condition fails and there is no else-branch).
Each branch is one expression; `do` groups several.

`when` and `unless` run a body of any length when the condition is truthy or falsey, and return `nil` otherwise.

`cond` takes condition–result pairs and returns the result of the first truthy condition; a lone final expression is the default.

`case` compares one value with several others using `=`:

```janet
(case size
  "small" 10
  "large" 25
  0)
```
