# Introduction

A string is text in double quotes: `"Hello"`.
Janet strings are _immutable_ — no function changes a string; functions that seem to modify one return a new string instead.

## Writing strings

Inside double quotes, a backslash starts an escape:

```janet
"Line one\nLine two"     # \n is a newline
"Tab\there"              # \t is a tab
"She said \"hi\""        # \" is a double quote
"C:\\temp"               # \\ is a backslash
```

A string between backticks is a _long string_: nothing inside is an escape, so it is handy for text full of backslashes or quotes.

```janet
`C:\temp\new`            # the backslashes are kept as they are
```

## Strings are bytes

A Janet string is a sequence of bytes, not of characters.
For plain ASCII text — English letters, digits and punctuation — every character is one byte, and everything works as you would expect.
Letters outside ASCII, like `é`, take more than one byte, so `(length "é")` is `2`.

`length` returns the number of bytes:

```janet
(length "badge")   # => 5
(length "")        # => 0
```

Looking up a single position with `get` returns the byte there as a number, not a one-letter string:

```janet
(get "Ada" 0)      # => 65, the code of "A"
```

To get a piece of a string as a string, use `string/slice`.

## Building strings with `string`

The `string` function joins its arguments into one new string.
It accepts numbers and other values too, and converts them to text.

```janet
(string "Ada" " " "Lovelace")      # => "Ada Lovelace"
(string "Table " 7)                # => "Table 7"
```

## Slicing

`(string/slice s start end)` returns the bytes from index `start` up to, but not including, index `end`.
Indexes start at 0.
Without `end`, the slice runs to the end of the string.
A negative index counts from the end, where `-1` means the very end of the string, one past the last byte.

```janet
(string/slice "Lovelace" 0 4)    # => "Love"
(string/slice "Lovelace" 4)      # => "lace"
(string/slice "Lovelace" -3)     # => "ce"
```

## Searching

```janet
(string/find "a" "banana")              # => 1, the index of the first match
(string/find "x" "banana")              # => nil, not found
(string/has-prefix? "ban" "banana")     # => true
(string/has-suffix? "na" "banana")      # => true
```

Note the argument order: the thing to look for comes first, then the string to look in.
This is true of most `string/` functions.

## Changing case and other transformations

```janet
(string/ascii-upper "Hello")             # => "HELLO"
(string/ascii-lower "Hello")             # => "hello"
(string/trim "  padded  ")               # => "padded"
(string/replace-all "a" "o" "banana")    # => "bonono"
```

As the names say, the case functions only change the ASCII letters A–Z.

## Formatting

`string/format` builds a string from a template, like `printf` in C.
Each `%` directive in the template is replaced by the next argument:

```janet
(string/format "%s has %d apples" "Ada" 3)   # => "Ada has 3 apples"
(string/format "%.2f" 3.14159)              # => "3.14", two decimals
(string/format "[%5d]" 42)                  # => "[   42]", at least 5 wide
(string/format "[%-5d]" 42)                 # => "[42   ]", left-aligned
```

- `%s` inserts a string, `%d` a whole number and `%f` a decimal number.
- A number right after `%` is the minimum _width_: shorter values are padded with spaces, on the left by default and on the right with `-`.
- `.` followed by a number is the _precision_: the number of decimals for `%f`, and the maximum number of bytes for `%s`.
- `%%` inserts a literal `%`.

## Comparing strings

`=` compares strings by their contents, and `<` and `>` compare them alphabetically, byte by byte.

```janet
(= "abc" "abc")      # => true
(< "apple" "pear")   # => true
```

## Pitfalls

- `(get s i)` gives a number, not a string; use `string/slice` for text.
- `string/slice` with an index beyond the string is an error, not an empty string.
- `%d` refuses numbers with a fractional part; use `%f` or round first.
