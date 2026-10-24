# Introduction

## Types with alternatives

A struct is one shape of data: every book has a title, an author and a year. Much data instead comes in one of
several forms. A traffic light is red, amber or green; a payment is cash, or a card with a number. Koka describes
such data with a `type` that lists its _constructors_, one per alternative:

```koka
type light
  Red
  Amber
  Green
```

`Red`, `Amber` and `Green` are the only values of type `light`. Constructor names start with a capital letter;
the type's name, like every name in Koka, is lower-case. A type whose constructors carry no data like this one is
often called an enumeration.

## Constructors with data

A constructor can carry fields, written like a function's parameters, and each constructor can carry different
ones:

```koka
type payment
  Cash
  Card(number : string, contactless : bool)
  Voucher(code : string, value : int)
```

A constructor with fields is used like a function, `Card("4111", True)`, and like the constructor of a struct it
accepts named arguments: `Voucher(value = 500, code = "SUMMER")`. A constructor without fields is just a value:
`Cash`. Types can of course be used in other types' fields, as `light` could be in a `crossing`.

Types and constructors so declared are private to the module; `pub type` exports them.

## Matching on constructors

Code that receives a `payment` does not know which form it has. A `match` finds out, with one branch per
constructor; the branch's pattern names the fields it binds:

```koka
fun describe(p : payment) : string
  match p
    Cash -> "cash"
    Card(number, _) -> "card " ++ number
    Voucher(code, value) -> "voucher " ++ code ++ " worth " ++ value.show
```

Patterns can look deeper. A field can be matched against a literal or another constructor, and branches are tried
from top to bottom, so put the specific ones first:

```koka
fun fee(p : payment) : int
  match p
    Card(_, True) -> 0       // contactless cards are free
    Card -> 10               // any other card
    _ -> 0
```

`Card` without parentheses matches a card whatever its fields. A pattern may also name a field instead of giving
them all by position: `Voucher(value = v) -> v`. Guards (`| condition`) work as for any other match.

## Predicates for free

For each constructor Koka defines a test, named `is-` followed by the constructor's name in lower case:

```koka
Cash.is-cash                     // True
Card("4111", False).is-voucher   // False
```

These are handy in conditions, where a whole `match` would be long-winded.

## Fields

A field that every constructor has — same name, same type — gets a reading function, as a struct's fields do. A
field only some constructors have does not: there is no `p.code`, because a `Cash` payment has no code to give.
Read such fields with a `match`.

## Pitfalls

- **Missing cases.** A `match` that leaves out a constructor still compiles, but Koka then adds the `exn` effect
  to the function, because the missing case would fail at run time. If the function's type promises no effects,
  it is rejected. Cover every constructor, or end with a `_` branch on purpose.
- **Order matters.** In the `fee` example above, putting `Card -> 10` first would make the contactless branch
  unreachable.
- **Nothing derived.** As for structs, there is no automatic `show` or `==` for your own types. Write a `match` that
  produces what you need.
