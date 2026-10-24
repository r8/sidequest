# Introduction

A character is written in single quotes, `'a'`, and is a Unicode code point; a single quote itself is `'''`.
`@` is the character with code point zero.

Characters combine with numbers by code point: a character plus or minus a number is a character, and the
difference of two characters is a number. Adding two characters is an error.

```bqn
'a' + 1      # 'b'
'c' - 'a'    # 2
@ + 65       # 'A'
'A' - @      # 65
```

Comparisons order characters by code point, so `('a' ≤ c) ∧ c ≤ 'z'` tests for a small English letter.
