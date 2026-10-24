# Introduction

## Characters

A character is written between single quotes: `'a'`, `'Z'`, `' '`, `'7'`. A single quote character is written
by doubling it inside the quotes: `'''`. Characters are values like numbers, and they are Unicode code points,
so `'é'` and `'λ'` are single characters too.

## Character arithmetic

Characters are not numbers, but they can be combined with numbers in a few ways that follow their position
in Unicode:

```bqn
'a' + 1        # 'b': a character plus a number is a character
'c' - 'a'      # 2: the distance between two characters is a number
'z' - 1        # 'y'
```

Adding two characters is an error: `'a' + 'b'` has no meaning.

`@` is the character with code point zero (the "null" character). Adding a number to it gives the character
with that code point, and subtracting it gives the code point back:

```bqn
@ + 65         # 'A'
'A' - @        # 65
@ + 10         # the newline character
```

Comparisons order characters by code point, so `'a' < 'b'` is `1`, and every capital letter of the English
alphabet comes before every small one.

## Strings are lists of characters

A string is written between double quotes. It is nothing but a list of characters:

```bqn
"hello"           # the same as ⟨'h', 'e', 'l', 'l', 'o'⟩
≠ "hello"         # 5
""                # the empty string, the same as ⟨⟩
```

A double quote inside a string is written twice: `"He said ""hi"""` is a string of 12 characters, starting
`He said "`. There are no other escapes; a newline is `@ + 10`.

Since a string is a list, everything from the lists lesson applies. `∾` joins strings, and a single character
counts as a one-element list:

```bqn
"abc" ∾ "def"             # "abcdef"
"Ann" ∾ " " ∾ "Lee"       # "Ann Lee"
"Ann" ∾ ' ' ∾ "Lee"       # the same, with a character in the middle
'x' ∾ "yz"                # "xyz"
```

Character arithmetic pervades over strings, just as number arithmetic does over lists of numbers:

```bqn
"abc" - 32                # "ABC": capitals are 32 code points before small letters
'a' + ↕ 5                 # "abcde"
"abc" = 'b'               # ⟨0, 1, 0⟩
("aZq" ≥ 'a') ∧ "aZq" ≤ 'z'   # ⟨1, 0, 1⟩: which characters are small letters
```

Combined with booleans as numbers, this changes only some of the characters: subtracting `32 × mask` takes 32
from the characters where the mask is `1` and leaves the others alone.

## Characters and one-character strings

`'x'` is a character, but `"x"` is a list holding one character. They are different values, and `'x' ≡ "x"` is
`0`. When a task asks for a string, return a list, even if it is only one character long.

## Lists of strings

Strings can be put in a list like any other value. Stranding works with string literals:

```bqn
"tea"‿"coffee"‿"juice"     # a list of three strings
≠ "tea"‿"coffee"‿"juice"   # 3: the number of strings, not of characters
```

Arithmetic still pervades into such a list: `"ab"‿"cd" - 32` is `"AB"‿"CD"`.
