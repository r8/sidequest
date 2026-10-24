# Introduction

`(table/setproto t proto)` gives the table `t` a prototype: a lookup of a key `t` does not have continues in `proto`, then in `proto`'s prototype, and so on.

```janet
(def Animal @{:legs 4 :speak (fn [self] (string (self :name) " makes a noise"))})
(def Dog (table/setproto @{:speak (fn [self] (string (self :name) " says woof"))} Animal))
(def rex (table/setproto @{:name "Rex"} Dog))

(rex :legs)   # => 4, inherited from Animal
(:speak rex)  # => "Rex says woof"
```

Calling a keyword, `(:speak rex args…)`, is a method call: it looks `:speak` up along the chain and calls it with `rex` as the first argument, conventionally named `self`.

`put` always writes to the table itself, shadowing the prototype's value.
`table/getproto` returns a table's prototype, `table/rawget` ignores the chain, and `keys`, `pairs` and `eachp` see only a table's own keys.
