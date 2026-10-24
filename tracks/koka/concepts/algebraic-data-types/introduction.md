# Introduction

A `type` lists the forms a value can take, one constructor per alternative. Constructors start with a capital
letter and may carry fields:

```koka
type payment
  Cash
  Card(number : string, contactless : bool)
```

`Cash` is a value; `Card("4111", True)` builds one from its fields. A `match` tells the forms apart and binds the
fields, and patterns can match fields against literals or other constructors (`Card(_, True)`); branches are tried
top to bottom. Koka defines an `is-cash`/`is-card` test per constructor, and a reading function only for a field
that every constructor has. A match that misses a constructor gives the function the `exn` effect.
