# About

## Notation

BQN has two ways to write a list. Brackets `⟨…⟩` take any expressions, separated by `,`, `⋄` or newlines.
Stranding with `‿` joins single values (literals, names, or parenthesised expressions) and binds more tightly
than any function: `2 × 1‿2‿3` is `2 × ⟨1,2,3⟩`. A strand cannot have just one element, so a one-element list
is `⟨x⟩`. Strands nest by parenthesising: `(1‿2)‿3` is `⟨⟨1,2⟩,3⟩`, a list whose first element is a list.

A list is a one-dimensional array. Later lessons generalise to arrays with any number of axes; everything here
carries over.

## Pervasion

The arithmetic functions (`+ - × ÷ ⋆ √ ⌊ ⌈ |`), the comparisons and the logic functions are _pervasive_: they
go all the way into nested lists and act on each number.

```bqn
1‿2‿3 + ⟨10, 20‿30, 40⟩    # ⟨11, ⟨22, 32⟩, 43⟩
```

When both arguments are lists their lengths must match; a single value (an _atom_) pairs with every element.
Other primitives such as `≠`, `∾` and `↕` are not pervasive: they work on the list as a whole.

## Length, range and join

- `≠ 𝕩` is the length; on a single number it is `1`.
- `↕ n` needs a natural number and gives `⟨0, …, n-1⟩`; `↕ 0` is `⟨⟩`. With a list of numbers it makes an
  array of indices, covered later.
- `𝕨 ∾ 𝕩` joins; with one argument, `∾` joins a list of lists into one, as the nesting lesson shows.

## Equality

`=` compares element by element, so it needs equal lengths and returns a list. `≡` (match) compares two whole
values and returns a single boolean, whatever their lengths; `≢` is its negation with two arguments.

## Counting from zero

Indices and ranges in BQN start at zero. When a report counts from one, add `1` to the range: `1 + ↕ ≠ list`.
