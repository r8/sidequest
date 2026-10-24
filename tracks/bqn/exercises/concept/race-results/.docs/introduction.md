# Introduction

## Sorting

`∧ 𝕩` sorts a list into ascending order and `∨ 𝕩` into descending order. (With two arguments the same symbols
are logical and and or; with one they sort.)

```bqn
∧ 31‿27‿35‿27    # ⟨ 27 27 31 35 ⟩
∨ 31‿27‿35‿27    # ⟨ 35 31 27 27 ⟩
∧ "banana"       # "aaabnn"
```

Sorting works on any list, not only numbers. BQN has a single ordering for all values: numbers come before
characters, characters are ordered by their code points, and lists are compared element by element, like
words in a dictionary, with a shorter list first when one is the start of the other. So a list of strings
sorts alphabetically:

```bqn
∧ "Zoe"‿"Bo"‿"Al"‿"amy"    # ⟨ "Al" "Bo" "Zoe" "amy" ⟩
```

Note that `"amy"` comes last: every uppercase letter has a smaller code point than every lowercase one.

## Grading

Often you don't want the sorted values themselves but the _order_ that sorts them. `⍋ 𝕩` (grade up) returns
the indices of `𝕩` in the order that would sort it, and `⍒ 𝕩` (grade down) the order that would sort it
descending:

```bqn
times ← 31‿27‿35‿27
⍋ times     # ⟨ 1 3 0 2 ⟩: the smallest is at index 1, then index 3, …
⍒ times     # ⟨ 2 0 1 3 ⟩
```

Selecting with a grade sorts: `(⍋𝕩) ⊏ 𝕩` is the same as `∧ 𝕩`. The real use of a grade is to sort one list
by the values of another. Here the names are put in the order of their times:

```bqn
names ← "Ana"‿"Ben"‿"Cy"‿"Dee"
(⍋ times) ⊏ names     # ⟨ "Ben" "Dee" "Ana" "Cy" ⟩
```

The first index of a grade is the position of the smallest value, so `⊑ ⍋ times` is `1`, the index of the
fastest time, and `(⊑ ⍋ times) ⊑ names` is `"Ben"`.

## Ties

Grades are _stable_: equal values keep the order they had. Ben and Dee both ran 27, and Ben, who comes first
in the list, comes first in the grade. The same holds for `⍒`: equal values stay in their original order, they
are not reversed.

```bqn
⍒ 3‿5‿5‿1     # ⟨ 1 2 0 3 ⟩
```

## Ranks from a grade

A grade says which element is in each place. Grading the grade turns it around and says which place each
element is in:

```bqn
⍋ times         # ⟨ 1 3 0 2 ⟩
⍋ ⍋ times       # ⟨ 2 0 3 1 ⟩: Ana is in place 2, Ben in place 0, …
```

`⍋⍋` gives places counting from 0, in the original order of the list.

## Pitfalls

- `∧` and `∨` give values; `⍋` and `⍒` give indices. Select with the indices to put another list in that
  order.
- Sorting strings compares code points, so capitals sort before small letters.
- The grade of an empty list is empty, and so is its sort: `∧ ⟨⟩` is `⟨⟩`.
