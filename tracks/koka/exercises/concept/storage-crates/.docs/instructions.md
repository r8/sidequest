# Instructions

Halvorsen & Daughters store anything for anyone: bicycles, harps, crates of turnips. Their warehouse software was
written for turnips only, and every new kind of goods has meant copying it. You are rewriting it once, for goods of
any type. A storage space is a `crate<a>`:

```koka
pub type crate<a>
  Vacant
  Holding(item : a)
```

## 1. Swap two loads

The forklift picks up a pair of loads and puts them down the other way round. Define the `swap` function: it
takes a pair and returns it with its two halves exchanged.

```koka
swap((1, "harp"))
// => ("harp", 1)
```

## 2. Fill crates

Define the `fill` function: it takes a list of items and returns a list of crates, each holding one of the items,
in the same order.

```koka
fill(["turnip", "harp"])
// => [Holding("turnip"), Holding("harp")]
```

## 3. Unpack a crate

Define the `unpack` function: it takes a crate and a fallback, and returns the crate's item, or the fallback if
the crate is vacant.

```koka
Holding(7).unpack(0)
// => 7
Vacant.unpack(0)
// => 0
```

## 4. Repack a crate

Some goods are processed in storage: turnips are pickled, harps are tuned. Define the `repack` function: it takes
a crate and a function, and returns a crate holding the function's result for the item. A vacant crate stays
vacant.

```koka
Holding(3).repack(fn(n) n.show ++ " kg")
// => Holding("3 kg")
```

## 5. Look for an item

Define the `holds` function: it takes a list of crates, the item looked for, and a function that tells whether two
items are the same, and returns whether any crate holds that item.

```koka
[Vacant, Holding("harp")].holds("harp", fn(x, y) x == y)
// => True
```
