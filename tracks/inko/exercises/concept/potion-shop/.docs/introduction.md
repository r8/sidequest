# Introduction

Some values are always exactly one of a fixed set of possibilities: a traffic light is red, amber or green; a
payment is cash or card. An _enum_ (Inko's algebraic data type) describes such a value. It is defined with
`type enum`, listing its _cases_:

```inko
type pub enum Light {
  case Red
  case Amber
  case Green
}
```

A value of the enum is created by naming the type and the case:

```inko
let light = Light.Amber
```

`Light(…)` doesn't work for enums: you always pick a case.

## Cases with data

A case can carry values, written as types in parentheses. Different cases can carry different data, or none:

```inko
type pub enum Payment {
  case Cash(Int)            # the amount in cents
  case Card(String, Int)    # the card number and the amount
  case Voucher
}

Payment.Cash(500)
Payment.Card('4111-1111', 1250)
Payment.Voucher
```

This is what makes enums so useful: a `Card` payment always has a card number, a `Cash` payment never does, and
the type system knows it. `Option` is an enum like this one, with the cases `Some(T)` and `None`.

## Matching on enums

`match` is how you find out which case you have, and gets at its data. The case patterns are written without the
type name:

```inko
fn pub amount(payment: ref Payment) -> Int {
  match payment {
    case Cash(cents) -> cents
    case Card(_, cents) -> cents
    case Voucher -> 0
  }
}
```

When every case is listed, the match is exhaustive and needs no `_` wildcard. That's a real advantage: if you later
add a case to the enum, the compiler points out every `match` that doesn't handle it yet. A wildcard would hide
that, so prefer listing the cases.

Patterns can look inside the data, too: `case Cash(0) -> …` only matches cash payments of zero, and guards work as
usual.

## Methods on enums

Like any type, an enum can have methods, defined inside it after the cases. `self` is the enum value, so an instance
method usually starts by matching on it:

```inko
type pub enum Light {
  case Red
  case Amber
  case Green

  fn pub next -> Light {
    match self {
      case Red -> Light.Green
      case Green -> Light.Amber
      case Amber -> Light.Red
    }
  }

  fn pub stop? -> Bool {
    match self {
      case Green -> false
      case _ -> true
    }
  }
}

Light.Red.next  # => Light.Green
Light.Red.stop? # => true
```

Notice the difference between patterns and values: in a `case` you write `Red`, but to create a value you write
`Light.Red`.

Static methods work too, for example to turn some input into a case. Methods that may fail to find a case return
an `Option`:

```inko
fn pub static parse(color: String) -> Option[Light] {
  match color {
    case 'red' -> Option.Some(Light.Red)
    case 'amber' -> Option.Some(Light.Amber)
    case 'green' -> Option.Some(Light.Green)
    case _ -> Option.None
  }
}
```

## Comparing enums

Enums don't compare with `==` until you implement the `Equal` trait for them, which the traits lesson covers. The
stub for this lesson already contains that code for `Potion`, so the tests can compare potions; you don't need to
change it.
