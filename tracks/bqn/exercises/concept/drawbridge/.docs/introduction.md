# Introduction

## Comparisons give numbers

BQN has no separate true and false values. A comparison returns the number `1` when it holds and `0` when
it does not:

```bqn
3 = 3      # 1
3 ≠ 4      # 1
2 < 1      # 0
5 ≥ 5      # 1
```

The six comparison functions are `=` (equal), `≠` (not equal), `<`, `>`, `≤` and `≥`. A `1` or `0` used as
a truth value is called a _boolean_.

Only call the comparisons with two arguments for now. With a single argument, `=`, `≠` and `≢` mean
something quite different (they describe the shape of a list or array, which later lessons cover), so
`≠ 3` is not "not 3".

## And, or, not

`∧` (and), `∨` (or) and `¬` (not) combine booleans:

```bqn
1 ∧ 0      # 0
1 ∨ 0      # 1
¬ 1        # 0
```

They are really arithmetic: `∧` is multiplication, `¬` is one minus its argument, and `∨` is `𝕨 + 𝕩 - 𝕨 × 𝕩`.
On `1` and `0` that is exactly the logic you expect. On other numbers they give other numbers (`¬ 3` is
`¯2`), so use them on booleans only.

To check that two booleans differ, which other languages call "exclusive or", compare them: `a ≠ b`.
Likewise `a = b` checks that they agree.

## Right to left, again

Comparisons follow the same right-to-left rule as every other function. This catches out newcomers when
combining conditions:

```bqn
x ← 7
x > 1 ∧ x < 5       # 1, wrong: it means x > (1 ∧ (x < 5)), which is 7 > 0
(x > 1) ∧ x < 5     # 0: the intended "x is between 1 and 5"
```

Put parentheses around every condition except the rightmost one. A range check reads well like this:

```bqn
InRange ← {(1 ≤ 𝕩) ∧ 𝕩 ≤ 10}
InRange 7     # 1
InRange 12    # 0
```

## Booleans are numbers

Because booleans are ordinary numbers, they can be added and multiplied. Adding booleans counts how many
conditions hold, and multiplying by a boolean keeps an amount or turns it into zero:

```bqn
(3 > 1) + (4 < 9) + 2 = 5   # 2: two of the three hold
price ← 12
member ← 1
price × ¬ member            # 0: members pay nothing
10 + 5 × member             # 15: a bonus only for members
```

This is how BQN code makes many decisions without any branching: compute the boolean, then use it as a
number.

## Using one function in another

A boolean function is an ordinary function, and its result can feed another:

```bqn
IsTeen ← {(13 ≤ 𝕩) ∧ 𝕩 ≤ 19}
NeedsTicket ← {¬ IsTeen 𝕩}
NeedsTicket 15     # 0
```

On the keyboard, `\/` gives `≠`, `\<` gives `≤`, `\>` gives `≥`, `\t` gives `∧`, `\v` gives `∨` and `\~`
gives `¬`.
