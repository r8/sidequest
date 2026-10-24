# Introduction

A string is a list of characters, written in double quotes: `"hello"` is `⟨'h','e','l','l','o'⟩`, and `""` is
the empty list. A double quote inside a string is doubled: `"say ""hi"""`. There are no backslash escapes.

Everything that works on lists works on strings: `≠` gives the length, `∾` joins (a single character counts
as a one-element string), and character arithmetic and comparisons pervade:

```bqn
"Ann" ∾ ' ' ∾ "Lee"    # "Ann Lee"
"abc" - 32             # "ABC"
"abc" = 'b'            # ⟨0, 1, 0⟩
```

`'x'` and `"x"` differ: the first is a character, the second a list of one.
