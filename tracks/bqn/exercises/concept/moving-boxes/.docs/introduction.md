# Introduction

## Arrays inside arrays

The elements of a BQN list can be anything, including other lists. A list of strings is a list of lists of
characters; a list can hold numbers and lists side by side:

```bqn
⟨1, ⟨2, 3⟩, 4⟩      # three elements; the second is a list
```

Arrays that contain arrays are _nested_. Each element is a single value of the outer list, however much it
holds itself: `≠ ⟨1, ⟨2, 3⟩, 4⟩` is `3`.

## Depth

`≡ 𝕩` (depth) says how deeply an array is nested. A number or character has depth 0, a list of them depth 1,
and each level of nesting adds one. The depth counts the deepest element:

```bqn
≡ 5                        # 0
≡ "cup"                    # 1
≡ "cup"‿"plate"            # 2
≡ ⟨1, ⟨2, ⟨3⟩⟩⟩            # 3
```

## Enclose

`< 𝕩` (enclose) wraps any value into an array with no axes and a single element. The result has depth one
more than `𝕩`, and is treated as _one_ value by functions that work on elements. That is how you make a whole
list act as a single element:

```bqn
"cup"‿"mug" ∾ "bowl"       # ⟨ "cup" "mug" 'b' 'o' 'w' 'l' ⟩: four characters added
"cup"‿"mug" ∾ <"bowl"      # ⟨ "cup" "mug" "bowl" ⟩: one string added
```

The same trick pairs a whole list with every element when using each: `"cup"‿"mug" ≡¨ <"cup"` compares each
string with `"cup"`, giving `⟨ 1 0 ⟩`. Without `<`, each would try to pair the two strings with the three
characters of `"cup"`. `⊑` takes the value back out: `⊑ <"bowl"` is `"bowl"`.

## Pair

`𝕨 ⋈ 𝕩` (pair) makes a two-element list of its arguments, whatever they are; `⋈ 𝕩` makes a one-element list:

```bqn
"kitchen" ⋈ "cup"‿"mug"    # ⟨ "kitchen" ⟨ "cup" "mug" ⟩ ⟩
⋈ "cup"                    # ⟨ "cup" ⟩
```

Stranding, `a‿b`, does the same for two values written out, but `⋈` is a function, so it works on the results
of expressions and on arguments in a block.

## Join

`∾ 𝕩` (join) with one argument joins the elements of a list together, removing one level of nesting:

```bqn
∾ ⟨"cup"‿"mug", ⟨"plate"⟩, ⟨⟩⟩   # ⟨ "cup" "mug" "plate" ⟩
∾ "ab"‿"cd"                       # "abcd"
```

## Merge

`> 𝕩` (merge) also removes a level, but by building a bigger array: a list of lists of the same length becomes a
table with one row per list.

```bqn
> ⟨1‿2‿3, 4‿5‿6⟩      # a 2×3 table
≢ > "ab"‿"cd"‿"ef"    # ⟨ 3 2 ⟩
```

All the elements must have the same shape; merging lists of different lengths is an error.

## Match

`𝕨 ≡ 𝕩` (match) compares two whole values and returns a single 1 or 0: they match when they have the same shape
and their elements match all the way down. `𝕨 ≢ 𝕩` (not match) is its opposite. Compare with `=`, which goes
into its arguments and compares element by element:

```bqn
"cup"‿"mug" ≡ "cup"‿"mug"   # 1
1‿2 = 1‿2                   # ⟨ 1 1 ⟩
⟨5⟩ ≡ 5                     # 0: a list is not a number
```

## Pitfalls

- With one argument, `≡` is depth; with two, it is match. `≢` is shape with one argument, not match with two.
- `∾` with two arguments joins two lists; with one, it joins the lists inside a list.
- An enclosed value is not the value: `(<5) ≡ 5` is `0`.
