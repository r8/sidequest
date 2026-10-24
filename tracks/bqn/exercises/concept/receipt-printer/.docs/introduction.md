# Introduction

## Numbers are not text

A number and the text that shows it are different values. `42` is a number; `"42"` is a list of two
characters. You can't join a number to a string with `∾` and get the digits: `"Total: " ∾ 42` is a list of
seven characters and one number. To print a number in a sentence, you first turn it into text, and to compute
with a number you have read as text, you turn it back.

BQN does both with **system functions**, whose names start with `•`. You have already used one, `•Import`.
They give access to things outside the core language: files, the terminal, and conversions like these.

## Number to text: `•Fmt`

`•Fmt` formats a value as text, the way BQN would display it:

```bqn
•Fmt 42           # "42"
•Fmt 3.5          # "3.5"
•Fmt 2 ÷ 3        # "0.6666666666666666"
•Fmt ¯2           # "¯2": with a high minus
•Fmt 1e20         # "1e20"
```

Whole numbers have no decimal point (`•Fmt 12.0` is `"12"`), and a number is shown with as many digits as it
needs, so `•Fmt` never rounds for you. To show a fixed number of decimals, round first and place the point
yourself (see below).

`•Fmt` works on any value: `•Fmt 1‿2` is `"⟨ 1 2 ⟩"` and `•Fmt "ab"` is `"""ab"""`, with the quotes. For a
receipt you will mostly give it single numbers.

## Text for programmers: `•Repr`

`•Repr` gives the text of BQN source code that would produce the value: `•Repr 1‿2` is `"1‿2"`,
`•Repr 'a'` is `"'a'"`. For a single number it is the same as `•Fmt`. It is mainly useful for debugging and
for error messages, when you want to show exactly what a value was.

## Text to number: `•ParseFloat`

`•ParseFloat` reads a number from a string:

```bqn
•ParseFloat "3.25"   # 3.25
•ParseFloat "-2"     # ¯2
•ParseFloat "1e3"    # 1000
```

It reads the usual notation, with an ordinary minus `-`, not BQN's `¯`. Anything else, including spaces, is an
error: `•ParseFloat " 2"` fails with "Malformed input".

Floating-point numbers can't hold most decimals exactly, so computing with parsed decimals may give results a
tiny bit off: `100 × •ParseFloat "0.29"` is `28.999999999999996`. Round to a whole number when you need one:
`⌊0.5 + x`.

## Padding with `↑`

Text in columns needs padding. You know that `n↑list` takes the first `n` elements and `(-n)↑list` the last `n`.
When `n` is longer than the list, Take pads it with a **fill** element, which is a space for strings:

```bqn
6 ↑ "ab"      # "ab    ": left-aligned in 6 columns
¯6 ↑ "42"     # "    42": right-aligned in 6 columns
```

To pad with something else, such as zeros, join the padding yourself and take from the end:

```bqn
¯3 ↑ "00" ∾ "5"     # "005"
```

Careful: if the text is already longer than `n`, Take cuts it, `¯2 ↑ "12345"` is `"45"`. Use the larger of the
two lengths, `n ⌈ ≠text`, when nothing may be cut.

## Fixed decimals

To show an amount of money stored as cents, format the whole number of cents and put the point before the last
two digits, with enough zeros in front that there is always a digit before the point:

```bqn
d ← •Fmt 1205          # "1205"
(¯2↓d) ∾ "." ∾ ¯2↑d    # "12.05"
```

Working in whole cents, rather than in decimal amounts, avoids floating-point surprises altogether.

## Printing

`•Show x` prints a value as `•Fmt` would, and `•Out text` prints a string as it is, without quotes. Both are
for debugging here: the tests check the values your functions return.
