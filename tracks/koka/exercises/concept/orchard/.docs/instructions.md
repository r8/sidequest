# Instructions

It is harvest time at Hollow Lane Orchard. The pickers bring in their apples in baskets, and at the end of the
day the farm shop wants to know what it can sell. Each day's baskets are recorded as a list of how many apples
are in each one.

## 1. Count the baskets that match

Define the `count-if` function: it takes the baskets and a test for a basket, and returns how many baskets pass
the test.

```koka
count-if([12, 30, 25], fn(apples) apples > 20)
// => 2
```

## 2. Allow for bruising

Some apples bruise on the way to the shop. Define the `bruise` function: it takes the baskets and how many
apples each basket loses, and returns the baskets with that many apples taken out of each — but a basket never
holds fewer than 0.

```koka
bruise([12, 3, 25], 4)
// => [8, 0, 21]
```

## 3. Pick the baskets to sell

Define the `ready-to-sell` function: it takes the baskets and the smallest number of apples a basket must hold
to go on sale, and returns the baskets that may be sold, in order.

```koka
ready-to-sell([12, 30, 25], 20)
// => [30, 25]
```

## 4. Check that the baskets are full

Define the `all-full` function: it takes the baskets and the capacity of a basket, and returns whether every
basket is filled to capacity.

```koka
all-full([40, 40, 39], 40)
// => False
```

## 5. Count the crates

The shop packs each basket's apples into crates of a fixed size, never mixing two baskets in one crate.
Define the `crates-needed` function: it takes the baskets and the size of a crate, and returns how many crates
are needed for them all.

```koka
crates-needed([12, 30, 25], 10)
// => 8
```
