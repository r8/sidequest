# Introduction

A keyword is a name with a leading colon, such as `:sunny`, that evaluates to itself.
Janet uses keywords for values from a fixed set — states, options, kinds of result — where other languages use enums or string constants.

Keywords are interned, so `=` compares them cheaply, and they work well with `case`.
A keyword never equals a string: `(= :sunny "sunny")` is `false`.

`keyword` builds one from strings, and `string` turns one back into text without the colon:

```janet
(keyword "rainy")    # => :rainy
(string :rainy)      # => "rainy"
```

Putting a keyword first in a call, `(:sunny x)`, is a method call, not a lookup.
