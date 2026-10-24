# Hints

## General

- The [Parsing Expression Grammars](https://janet-lang.org/docs/peg.html) page of the Janet documentation lists every pattern and capture, including grammars.
- [`peg/match`](https://janet-lang.org/api/peg.html) returns an array of captures, or `nil` when the pattern does not match.

## 1. Read an amount

- The `number` capture converts the text it matches.
- `-1` matches only at the end of the input; without it, `"15."` would match as `15`.
- `peg/match` returns an array of captures; you want its first element, and `(get nil 0)` is `nil`.

## 2. Read one entry

- `(/ "+" :add)` matches a `+` and captures `:add` instead.
- `group` turns the two captures into one array.
- You can put the amount pattern from the first task into this one with `,`.

## 3. Read a whole tape

- A grammar lets you name the entry as a rule and say "an entry, then any number of newline-and-entry".
- Remember the optional newline at the end, and the end of input.

## 4. Total a tape

- Start from 0 and apply each entry to the running total: `reduce` does exactly that.
- `case` on the operator keyword picks the arithmetic function.

## 5. Check the sums in the margin

- Write a rule for a _term_ — a number, or a sum in parentheses — and a rule for a _sum_ — a term followed by any number of operator-and-term pairs. The two rules refer to each other.
- Capture each operator as the function itself, for example `(* "+" (constant ,+))`.
- Wrap the sum in `(/ … ,f)` where `f` takes the first term and the grouped operator-and-term pairs and folds them from left to right.
