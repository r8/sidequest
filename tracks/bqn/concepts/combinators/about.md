# About

## The combinators

BQN's combinators take functions (or values) and return a function, without ever looking at the data
themselves:

| combinator | `F_G x` | `w F_G x` |
| --- | --- | --- |
| `F∘G` Atop | `F G x` | `F w G x` |
| `F○G` Over | `F G x` | `(G w) F (G x)` |
| `F⊸G` Before | `(F x) G x` | `(F w) G x` |
| `F⟜G` After | `x F G x` | `w F G x` |
| `F˜` Self / Swap | `x F x` | `x F w` |
| `F˙` Constant | `F` | `F` |
| `⊢` Right | `x` | `x` |
| `⊣` Left | `x` | `w` |

`∘` and `○` differ only with two arguments: Atop passes both to `G` (`⌊∘÷` is floor division), Over applies
`G` to each one (`=○≠` compares lengths, `+○(×˜)` adds squares, `≡○∧` compares the sorted lists).

## Binding

A subject in operand position is a constant function, which is how `2⊸×` and `×⟜2` bind an argument. The
value goes on the side of the arrow it is used on: `32⊸-` is `32 - x` and `-⟜32` is `x - 32`. A bound
function called with two arguments ignores the argument the constant replaces: `10 2⊸× 3` is `6`. When a
constant is wanted that is itself a function, `˙` makes one: `+˙` always returns the function `+`.

## Hooks

Without a constant, `⊸` and `⟜` are hooks that use one argument in two places. `F⊸G x` is `(F x) G x`:
`⌽⊸≡` tests for a palindrome, `⌈´⊸=` marks the largest elements. `F⟜G x` is `x F (G x)`: `÷⟜≠` divides
a list by its length, `∾⟜⌽` appends the reverse.

## Grouping

Modifiers bind tighter than function application and group left to right, and a strand binds tighter than
modifiers. Parentheses are needed around a bound operand on the right: `F∘(2⊸×)`, not `F∘2⊸×`, which groups
as `(F∘2)⊸×`. A right operand that is a single primitive or name needs none: `÷⟜1.8∘(-⟜32)`.

## Identity functions

`⊢` and `⊣` are the identity functions. They are mostly operands and train parts (a later lesson), but are
handy alone too: `⊣´` takes the first element of a list, `⊢´` the last, and `F⊢` in a train applies `F` to
the right argument only.

## Combinators and blocks

Every combinator can be written as a block, and a block is often clearer for anything long. The combinator form
shines for short pieces, like the operands of `¨` and `´`: `(2⊸×)¨`, `+´∘(×˜)`, `≠¨⊸/`.
