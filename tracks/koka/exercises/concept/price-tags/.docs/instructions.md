# Instructions

Grocer Abiodun prints a paper tag for everything on her shelves, and her till program has grown its own types for
prices and for how goods are sold:

```koka
// An amount of money, in cents.
pub struct money(cents : int)

// How an item is sold: by the piece or by weight.
pub type measure
  Each
  PerKilo
```

The printer only understands text, and the till can neither compare prices nor print them. Teach it.

## 1. Show an amount of money

Define `show` for `money` (as `money/show`): it returns the amount as a dollar sign, the whole dollars, a dot and
two digits of cents.

```koka
Money(305).show
// => "$3.05"
```

## 2. Show a measure

Define `show` for `measure` (as `measure/show`): `Each` is shown as `"each"` and `PerKilo` as `"per kilo"`.

```koka
PerKilo.show
// => "per kilo"
```

## 3. Compare amounts for equality

Define `==` for `money` (as `money/(==)`): two amounts are equal when they have the same number of cents.

```koka
Money(250) == Money(250)
// => True
```

## 4. Order amounts

Define `cmp` for `money` (as `money/cmp`): it returns `Lt`, `Eq` or `Gt` as the first amount is less than, equal
to or greater than the second.

```koka
cmp(Money(99), Money(250))
// => Lt
```

## 5. Print a tag line

Define the `label` function: it takes a name and a value of any type that has a `show`, and returns the name, a
colon, a space and the shown value.

```koka
label("turnips", Money(305))
// => "turnips: $3.05"
label("sold", PerKilo)
// => "sold: per kilo"
```

## 6. Find the cheapest

Define the `cheapest` function: it takes a list of values of any type that has a `cmp`, and returns the smallest
one, or `Nothing` for an empty list. If several are equally small, return the first of them.

```koka
cheapest([Money(305), Money(99), Money(250)])
// => Just(Money(99))
```
