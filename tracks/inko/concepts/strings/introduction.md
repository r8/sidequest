# Introduction

A `String` is immutable UTF-8 text, written in single or double quotes. `${…}` interpolates any value with a
`to_string` method, and `+` joins two strings:

```inko
let name = 'Ada'

'Hello, ${name}!'  # => 'Hello, Ada!'
'snow' + 'man'     # => 'snowman'
```

`size` counts bytes; `chars.count` counts characters (`'café'.size` is 5, `'café'.chars.count` is 4). Every method
returns a new string: `to_upper`, `to_lower`, `trim`, `replace`, `repeat`, `pad_start`, `substring` and more.
`starts_with?`, `ends_with?` and `contains?` answer questions about a string.
