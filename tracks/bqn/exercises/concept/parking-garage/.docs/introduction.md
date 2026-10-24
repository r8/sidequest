# Introduction

Booleans used as numbers go a long way, but sometimes a function has to do one thing or another: return a
string in one case and a number in the other, or avoid a calculation that would fail. BQN does this inside
blocks, with _predicates_ and _several bodies_.

## Several bodies

A block can have more than one _body_, separated by `;`. On its own that does nothing, because the first body
always runs. What makes a later body run is a predicate or a header that does not match.

## Predicates

A statement followed by `?` is a predicate. It must give `1` or `0`. If it gives `1`, the rest of the body
runs; if `0`, BQN abandons this body and moves on to the next one:

```bqn
Abs ← {𝕩 < 0 ? -𝕩 ; 𝕩}
Abs ¯4       # 4
Abs 3        # 3
```

Read `cond ? a ; b` as "if `cond`, then `a`, otherwise `b`". Chains of conditions are written by putting a
predicate in each body; the last body, without a predicate, is the "otherwise":

```bqn
Sign ← {𝕩 < 0 ? ¯1 ; 𝕩 > 0 ? 1 ; 0}
Size ← {𝕩 > 100 ? "large" ; 𝕩 > 10 ? "medium" ; "small"}
Size 50      # "medium"
```

The predicate must be exactly `0` or `1`, not some other number and not a list: anything else is the error
"Expected boolean". A predicate can be any expression, including a combination with `∧`:

```bqn
Teen ← {(13 ≤ 𝕩) ∧ 𝕩 ≤ 19 ? "teen" ; "not a teen"}
```

Only the chosen branch is evaluated, so a predicate can guard a calculation that would otherwise fail:

```bqn
Safe ← {𝕩 = 0 ? 0 ; 10 ÷ 𝕩}
```

If every body is abandoned and none is left, the call fails with "No header matched argument", so end a chain
with a body that always succeeds.

## Statements before a predicate

A predicate does not have to come first: a body can define local names and then test them. Each body is its
own block, though, so names defined in one body, including names from its header, do not exist in the next:

```bqn
Discount ← {
  price ← 𝕩 × 0.9
  price > 50 ? price - 5
  ;
  𝕩 × 0.9          # price is not defined here; only 𝕩 is
}
```

`𝕩` and `𝕨` are available in every body. When the next body needs the same names, give it the same header.

## Header patterns

The headers from the blocks lesson can hold literal values, and then a body runs only when the argument
matches. Combined with several bodies this picks a body by value:

```bqn
Name ← {𝕊 0: "zero" ; 𝕊 1: "one" ; 𝕊 n: "many"}
Name 1       # "one"
Name 7       # "many"
Wheels ← {𝕊 "bike": 2 ; 𝕊 "car": 4 ; 𝕊 𝕩: 0}
Wheels "car"     # 4
```

A list pattern such as `a‿b` only matches a list of that length, so patterns can also tell apart the shapes of
arguments.

## One argument or two

A header also says how many arguments a body takes. With `𝕊 𝕩:` and `𝕨 𝕊 𝕩:` bodies, the same function
behaves differently when called with one argument or two:

```bqn
Scale ← {𝕊 𝕩: 10 × 𝕩 ; 𝕨 𝕊 𝕩: 𝕨 × 𝕩}
Scale 3      # 30
2 Scale 3    # 6
```

Put the one-argument body first. A `𝕨 𝕊 𝕩:` header also accepts a call with one argument (`𝕨` is then
empty), so a `𝕊 𝕩:` body after it could never run, and BQN rejects the block with "Unreachable body". A
header that names or fixes the left argument, such as `v 𝕊 𝕩:` or `"HALF" 𝕊 𝕩:`, only matches calls with two.

Header patterns and predicates mix freely; BQN tries the bodies from left to right and runs the first one
whose header matches and whose predicates all hold.

On the keyboard, `?` and `;` are the ordinary keys.
