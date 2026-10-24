# About

## Strings are lists

BQN has no string type. `"abc"` is a list of three characters, and any list whose elements are all characters
displays as a string. This means there is no separate string library: the same primitives that reverse, search,
filter or split a list of numbers do so for text.

The empty string `""` and the empty list `⟨⟩` match (`"" ≡ ⟨⟩` is `1`). They differ only in their _fill_, the
element BQN uses when padding (a space for strings, `0` for numbers), which matters for some later primitives
such as take.

## Literals

Inside double quotes every character stands for itself, newlines included, except `"`, which is doubled. A
string with a computed character is built by joining: `"line one" ∾ (@+10) ∾ "line two"`.

## Lists of strings

A list of strings is a nested list: `"tea"‿"coffee"` has length 2, and each element has its own length.
Arithmetic still pervades into it (`"ab"‿"cd" - 32` is `"AB"‿"CD"`), but functions such as `≠` act on the outer
list. The each lesson shows how to apply them to every string.

## Characters versus strings

`'x'` is an atom and `"x"` a one-element list. `∾` accepts either, which is convenient when joining, but `≡`
tells them apart, and tests do too. When a function should return a string, return a list.

## Comparing strings

`=` compares two strings character by character and needs equal lengths. To ask whether two strings are the
same, use `≡`, which works for any lengths. Ordering strings alphabetically is done with sorting and grading,
covered in a later lesson.
