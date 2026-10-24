# Introduction

## Scan

A fold reduces a list to one value. A _scan_ keeps every step on the way. The 1-modifier `` ` `` (a backtick)
returns a list as long as its argument, whose element `i` combines the first `i+1` elements:

```bqn
+` 5‿¯2‿10‿¯4      # ⟨5, 3, 13, 9⟩: the running total
```

The first element is passed through unchanged; each later element is combined with the result just before it.
So `` +` `` gives running totals, `` ×` `` running products, and `` ⌈` `` and `` ⌊` `` the largest and smallest
values so far:

```bqn
⌈` 3‿1‿4‿1‿5       # ⟨3, 3, 4, 4, 5⟩
⌊` 3‿1‿4‿1‿5       # ⟨3, 1, 1, 1, 1⟩
```

## Scans on booleans

Scans with `∧` and `∨` answer "so far" questions about a list of `1`s and `0`s:

```bqn
∧` 1‿1‿0‿1         # ⟨1, 1, 0, 0⟩: 1 until the first 0
∨` 0‿0‿1‿0         # ⟨0, 0, 1, 1⟩: 1 from the first 1 on
```

`` ∧` `` marks the stretch at the start where everything held; `` ∨` `` marks everything from the moment something
first happened. Combined with comparison and fold, these are a compact way to find where a condition starts or
stops:

```bqn
temps ← 12‿15‿19‿14‿21
∨` temps > 18          # ⟨0, 0, 1, 1, 1⟩: from the first day above 18
+´ ¬ ∨` temps > 18     # 2: days before that
```

## Scan goes left to right

Unlike fold, scan combines from the left: element `i` of the result is the previous result combined with element
`i`, in that order. For `-` this gives

```bqn
-` 1‿2‿3           # ⟨1, ¯1, ¯4⟩: 1, then 1 - 2, then ¯1 - 3
```

For a block operand, `𝕨` is the result so far and `𝕩` the next element:

```bqn
{𝕨 ∾ 𝕩}` "ab"‿"c"‿"de"     # ⟨"ab", "abc", "abcde"⟩
```

This order lets a scan model something that changes step by step, such as a balance or a position, where each
step depends on the state before it.

## Initial value

Given a left argument, a scan starts from it: the first element of the result is the initial value combined with
the first element of the list, and the initial value itself is not included in the result.

```bqn
100 +` 5‿¯2‿10     # ⟨105, 103, 113⟩
10 -` 1‿2          # ⟨9, 7⟩
```

A scan of an empty list is an empty list, with or without an initial value, and the operand is never called. A
scan needs a list: `` +` 5 `` is an error.

## Scan and fold

The last element of a scan is the fold of the same list combined left to right, so for `+` it is the same as
`+´`: `` +` `` gives every running total, `+´` only the final one. When you need only the final value, fold;
when you need the history, scan.
