# Introduction

Numbers and the text showing them are different values; system functions convert between them.

- `•Fmt x` formats a value as BQN displays it: `•Fmt 3.5` is `"3.5"`, `•Fmt ¯2` is `"¯2"`.
- `•Repr x` gives source code for the value: `•Repr 1‿2` is `"1‿2"`.
- `•ParseFloat text` reads a number: `•ParseFloat "-2.5"` is `¯2.5`. It expects `-`, not `¯`, and fails on
  anything else.

Take pads with spaces when asked for more than there is, so `¯6↑"42"` right-aligns in six columns and `6↑"ab"`
left-aligns. For fixed decimals, keep amounts in whole units (cents), format them, and insert the point:
`(¯2↓d) ∾ "." ∾ ¯2↑d`.
