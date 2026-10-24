# Introduction

## Pervasive functions

Arithmetic and comparison in BQN are _pervasive_: they reach into a list, and into lists inside lists, until they
find the numbers and characters, and work on those.

```bqn
1‿2‿3 × 10                    # ⟨10, 20, 30⟩
⟨200‿240, ⟨300⟩⟩ ÷ 60         # ⟨⟨3.33…, 4⟩, ⟨5⟩⟩
"band" - 32                   # "BAND"
```

Most other functions are not pervasive. They treat their argument as a whole: `≠` gives the length of the
list it is given, and `∾` joins two whole lists. On a list of strings, `≠` counts the strings, not their
characters:

```bqn
setlist ← "Intro"‿"Lights Out"‿"Home"
≠ setlist        # 3
```

To apply such a function to every element, you need a modifier.

## Modifiers

A _modifier_ takes a function and makes a new function from it. `¨`, called _each_, is a 1-modifier: it is
written directly after the function it modifies, its _operand_, and the pair `≠¨` is a function like any other.

```bqn
≠¨ setlist       # ⟨5, 10, 4⟩: the length of each title
```

Modifiers bind more tightly than function application, so `≠¨ setlist` is `(≠¨) setlist`, and the operand is
just the one function, name or block immediately to the left of the `¨`. A block works as an operand too:

```bqn
{"Next up: " ∾ 𝕩 ∾ "!"}¨ setlist
# ⟨"Next up: Intro!", "Next up: Lights Out!", "Next up: Home!"⟩
```

The result always has as many elements as the argument, in the same order. Each element of the result is
whatever the operand returned for the matching element, so the operand can return numbers, strings, or anything
else.

## Each with two arguments

When the function made by `¨` gets a left argument, it pairs up the elements of both lists and calls its operand
on each pair:

```bqn
"Intro"‿"Home" {𝕨 ∾ " by " ∾ 𝕩}¨ "Ana"‿"Cy"
# ⟨"Intro by Ana", "Home by Cy"⟩
```

The two lists must have the same length; otherwise it is an error (`Mapping: Expected equal shape prefix`).

A pitfall: a string is itself a list, so `"!" ∾¨ setlist` tries to pair the one character of `"!"` with three
titles and fails. To use the same value with every element, refer to it from inside a block instead:

```bqn
{𝕩 ∾ "!"}¨ setlist     # ⟨"Intro!", "Lights Out!", "Home!"⟩
```

## Each inside each

The result of `≠¨` is a function, so it can be modified again. `≠¨¨` applies `≠¨` to each element; on a list of
lists of strings, that is the length of every string:

```bqn
sets ← ⟨"Intro"‿"Home", ⟨"Encore"⟩⟩
≠¨ sets         # ⟨2, 1⟩: songs per set
≠¨¨ sets        # ⟨⟨5, 4⟩, ⟨6⟩⟩: letters per title
```

## When not to use each

There is no need to write `{𝕩 × 2}¨ list` when `list × 2` already works on every element. Each is for functions
that would otherwise see the whole list; using it with pervasive arithmetic is slower and longer. On a string,
`≠¨` gives `1` for every character, since a single character is not a list.
