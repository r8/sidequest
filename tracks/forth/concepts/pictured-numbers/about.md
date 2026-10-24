# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `<#` | `( -- )` | start a picture |
| `#` | `( ud1 -- ud2 )` | one digit: `ud1` divided by `base`, the remainder becomes the digit |
| `#s` | `( ud -- 0 0 )` | digits until zero; at least one |
| `hold` | `( c -- )` | insert a character |
| `holds` | `( c-addr u -- )` | insert a string (Forth 2012; not in gforth 0.7.3) |
| `sign` | `( n -- )` | insert `-` if `n` is negative |
| `#>` | `( xd -- c-addr u )` | drop the double, leave the picture |

The conversion is unsigned and double-width.
For a non-negative single, push `0`; for a signed one, the idiom is `dup abs 0 <# … rot sign #>`, or with `s>d` (see double-cells) `tuck dabs <# … rot sign #>` for full-range values.

## Building right to left

The picture is filled from the end, so code reads backwards: the last `hold` is the first character.
Fixed layouts use `#` for every digit that must appear and `hold` for separators: `# # # #` pads to four digits, and a `[char] , hold` between groups of three digits separates thousands.
Since every `#` divides by `base`, a value made of parts in different radixes (minutes and seconds) is easiest to split with `/mod` first and then picture part by part.

## The buffer

The picture area (`#>`'s result) is shared by every pictured conversion in the system, including `.` and `u.`.
Using a result after another conversion reads garbage; copy it into a buffer of your own if it must survive.
Its size is limited — the standard guarantees room for a double-cell number in binary plus two characters — so long text belongs in a buffer of your own.

## Printing words built on it

- `.` `( n -- )` and `u.` `( u -- )` print with a trailing space.
- `.r` `( n width -- )` and `u.r` print right-aligned in a field.
- `d.` and `d.r` print doubles.
- gforth's `.s` shows the stack in the current base.
