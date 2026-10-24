# About

## `•Fmt`

`•Fmt` returns the text BQN's REPL would print for a value. For numbers that is the shortest text that reads
back as the same number: `•Fmt 0.1+0.2` is `"0.30000000000000004"`, `•Fmt 12.0` is `"12"`, large and small
numbers use exponents (`"1e20"`), negatives use `¯`, and `∞` and `NaN` are spelled out. Characters come with
their quotes (`"'a'"`), strings with doubled quotes, and arrays in their display form, `"⟨ 1 2 ⟩"`, with boxes
for tables.

For text meant for people, format numbers one by one and assemble the text yourself. Replace `¯` with `-` if
the reader expects it.

## `•Repr`

`•Repr` returns BQN source code: `•Repr 1‿2` is `"1‿2"`, `•Repr ⟨3, "ab"⟩` is `"⟨3,""ab""⟩"`. Evaluating the text
gives back an equal value (for data, not functions). It is the right choice for debugging output and for error
messages that quote a value; the track's test harness uses it to show "expected …, got …".

## `•ParseFloat`

`•ParseFloat` reads one number in the usual decimal or exponent notation, with an optional leading `-`:
`"12"`, `"3.25"`, `"-0.5"`, `"1e3"`. It fails with "Malformed input" on anything else, including BQN's `¯`,
leading or trailing spaces, and an empty string; strip or check the text first. To read a whole number from
its digits without it, a fold does the job: `+⟜(10⊸×)´⌽ "123"-'0'` is `123`.

## Padding and alignment

`n↑text` with `n` larger than the length pads on the right with the fill element, a space for strings;
`(-n)↑text` pads on the left. Both cut text that is too long, so use `(n⌈≠t)↑t` when nothing may be lost. To
pad with another character, join it first and take from the end (`¯3↑"00"∾d` for leading zeros), or replace
the spaces after taking.

## Decimals

BQN has no rounding format. Keep money and other fixed-point quantities as whole numbers of the smallest unit,
convert with `⌊0.5+100×x` when reading, and insert the decimal point when writing. This avoids both the
display surprises of `•Fmt` and floating-point drift in sums.

## Output

`•Out text` writes a string and a newline to standard output; `•Show x` writes `•Fmt x` and returns `x`, so it
can be placed in the middle of an expression to see an intermediate value.
