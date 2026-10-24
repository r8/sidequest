# Introduction

A `String` is a piece of UTF-8 encoded text. Strings are written between single or double quotes; the two are
the same:

```inko
'hello'
"hello"
```

Strings are **immutable**: no method changes a string in place. Methods such as `to_upper` return a new string
and leave the original as it was. Strings are also cheap to copy, so you can pass them around freely.

## Escapes and interpolation

A backslash starts an escape sequence: `\n` (newline), `\t` (tab), `\\` (a backslash), `\'` and `\"` (quotes),
`\$` (a dollar sign), and `\u{1F600}` (a Unicode code point).

`${…}` inside a string evaluates an expression and inserts it. The expression must have a `to_string` method,
which `Int`, `Float`, `Bool` and `String` all do:

```inko
let name = 'Ada'
let age = 36

'${name} is ${age} years old' # => 'Ada is 36 years old'
'${age + 1} next year'        # => '37 next year'
```

To turn a value into a string outside interpolation, call `to_string` yourself: `42.to_string` is `'42'`.

## Joining strings

`+` joins two strings into a new one:

```inko
'snow' + 'man' # => 'snowman'
```

Both sides must be strings, so `'room ' + 7` doesn't compile; use `'room ' + 7.to_string` or `'room ${7}'`.

## Bytes and characters

`size` is the number of _bytes_ in a string, not the number of characters. For plain English text the two are the
same, but many characters take more than one byte:

```inko
'cafe'.size        # => 4
'café'.size        # => 5, because é takes two bytes
'café'.chars.count # => 4
```

`chars` gives the characters one by one (more on that in a later lesson); `chars.count` counts them. Inko's
characters are what a reader would call characters: `'👍🏽'.chars.count` is `1`, even though it is made of two code
points and eight bytes.

## Comparing

`==` and `!=` compare two strings, character for character. `<` and `>` compare them in byte order, which matches
alphabetical order for lowercase ASCII letters.

## Useful methods

```inko
'Hello'.to_upper                   # => 'HELLO'
'Hello'.to_lower                   # => 'hello'
'  padded  '.trim                  # => 'padded'
'  padded  '.trim_start            # => 'padded  '
'Hello'.starts_with?('He')         # => true
'Hello'.ends_with?('lo')           # => true
'Hello'.contains?('ell')           # => true
'a-b-c'.replace('-', '+')          # => 'a+b+c'
'ab'.repeat(3)                     # => 'ababab'
'7'.pad_start(with: '0', chars: 3) # => '007'
'7'.pad_end(with: '.', chars: 3)   # => '7..'
'Hello'.substring(1, 3)            # => 'el', characters 1 up to (not including) 3
''.empty?                          # => true
```

`pad_start` and `pad_end` fill a string up to a number of characters; a string that is already long enough is
returned unchanged. Methods can be chained, each working on the result of the one before:

```inko
'  shout  '.trim.to_upper # => 'SHOUT'
```
