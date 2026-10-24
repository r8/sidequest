# Instructions

Teodor has kept the accounts of his bicycle repair shop on the same mechanical adding machine for forty years.
Each operation he keys in is printed on a paper tape, one per line: an operator, a space, and an amount.

```text
+ 120
- 15.50
* 2
```

His granddaughter wants to move the accounts to a computer without retyping a single tape, so she has scanned them.
Your job is to read the scans.

## 1. Read an amount

Define the function `parse-amount` that takes a string and returns the amount it holds as a number, or `nil` when the whole string is not an amount.
An amount is an optional `-`, one or more digits, and optionally a `.` followed by one or more digits.

```janet
(parse-amount "15.50")
# => 15.5

(parse-amount "15.")
# => nil
```

## 2. Read one entry

Define the function `parse-entry` that takes one line of a tape and returns the entry it holds as a pair: a keyword for the operator — `:add` for `+`, `:sub` for `-`, `:mul` for `*` and `:div` for `/` — and the amount.
The operator and the amount are separated by one or more spaces.
Return `nil` when the line is not an entry.

```janet
(parse-entry "- 15.50")
# => [:sub 15.5]

(parse-entry "% 3")
# => nil
```

## 3. Read a whole tape

Define the function `parse-tape` that takes a tape — entries separated by newlines, with an optional newline at the end — and returns an array of its entries in order.
Return `nil` when any line is not an entry.

```janet
(parse-tape "+ 120\n- 15.50\n* 2\n")
# => @[[:add 120] [:sub 15.5] [:mul 2]]
```

## 4. Total a tape

Define the function `tape-total` that takes a tape and returns the result of applying its entries in order, starting from 0.

```janet
(tape-total "+ 120\n- 15.50\n* 2")
# => 209
```

## 5. Check the sums in the margin

Teodor also scribbled sums in the margins, with parentheses: `120 - (15 + 5)`.
Define the function `evaluate` that takes such a sum and returns its value.
A sum is whole numbers (possibly negative) joined by `+` and `-`, evaluated from left to right; any number may be replaced by a sum in parentheses.
Spaces around numbers, operators and parentheses are optional.
Return `nil` when the text is not a sum.

```janet
(evaluate "120 - (15 + 5)")
# => 100

(evaluate "1 + (2")
# => nil
```
