# Introduction

## Group

Many problems come down to sorting things into piles: words by their first letter, orders by customer,
readings by day. BQN does this in one step with `⊔` (group). Its left argument says, for each element of the
right argument, which pile it goes in, counting piles from 0. The result is a list of piles:

```bqn
2‿0‿2‿1 ⊔ "abcd"       # ⟨ "b" "d" "ac" ⟩
```

`'a'` and `'c'` have pile number 2, so pile 2 is `"ac"`. Within each pile the elements keep their original
order. The left argument (the _group indices_) must have one number per element of the right argument.

There are as many piles as the largest index plus one, and a pile that nothing went into is empty:

```bqn
0‿3 ⊔ "ab"             # ⟨ "a" ⟨⟩ ⟨⟩ "b" ⟩
```

## Leaving elements out

An index of `¯1` means "no pile": that element is dropped from the result.

```bqn
1‿¯1‿0‿1 ⊔ "abcd"      # ⟨ "c" "ad" ⟩
```

## Setting the number of piles

Because the number of piles comes from the largest index, piles at the end that nothing went into are
missing: `0‿0 ⊔ "ab"` has a single pile, however many you expected. To ask for a certain number of piles, give
the left argument one extra number at the end. It is not a group index but the least number of piles the
result should have:

```bqn
0‿0‿4 ⊔ "ab"           # ⟨ "ab" ⟨⟩ ⟨⟩ ⟨⟩ ⟩
```

## Computing the group indices

The group indices are an ordinary list of numbers, so anything that computes numbers can decide the piles.
Arithmetic on positions splits a list into chunks:

```bqn
⌊ (↕7) ÷ 3                       # ⟨ 0 0 0 1 1 1 2 ⟩
(⌊ (↕7) ÷ 3) ⊔ "abcdefg"         # ⟨ "abc" "def" "g" ⟩
```

Searching turns values into indices. Index of, `𝕨 ⊐ 𝕩`, numbers each element by its position in a list of
keys you choose, so the piles come out in the order of the keys. Classify, `⊐ 𝕩`, numbers the distinct values in
the order they first appear, which groups equal values together:

```bqn
words ← "ant"‿"bee"‿"ape"‿"cat"
⊐ ⊑¨ words                       # ⟨ 0 1 0 2 ⟩: first letters a, b, a, c
(⊐ ⊑¨ words) ⊔ words             # ⟨ ⟨ "ant" "ape" ⟩ ⟨ "bee" ⟩ ⟨ "cat" ⟩ ⟩
```

## Group with one argument

`⊔ 𝕩` groups the _positions_ instead of the values: pile `i` holds the indices where `𝕩` is `i`.

```bqn
⊔ 2‿0‿2‿1              # ⟨ ⟨ 1 ⟩ ⟨ 3 ⟩ ⟨ 0 2 ⟩ ⟩
```

Each, `¨`, is handy for looking at the piles: `≠¨` gives their sizes, which counts how often each index occurs:

```bqn
≠¨ ⊔ 2‿0‿2‿1           # ⟨ 1 1 2 ⟩
```

(The same counts can also be written `/⁼ 2‿0‿2‿1`, using undo, which comes in a later lesson.)

## Pitfalls

- The result has a pile for every index up to the largest one, so empty piles appear in the middle, but not
  at the end unless you ask for them with the extra number.
- Group indices must be whole numbers from `¯1` up; anything else is an error.
- The left argument has as many numbers as the right has elements (or one more, to set the length).
