# Instructions

The Hollow Oak orchard picks its apples by hand. At the end of each day the pickers weigh and count their baskets
and pack the apples into crates for the market. The orchard's owner, Ines, wants a few helpers for the paperwork.

## 1. Count the full crates

Define the `full_crates` method, which takes the number of apples picked and how many apples fit in a crate, and
returns how many crates can be filled completely:

```inko
full_crates(apples: 100, per_crate: 24)
# => 4
```

## 2. Count the apples left over

Apples that don't fill a crate are sold loose at the farm gate. Define the `loose_apples` method, which takes the
same two arguments and returns how many apples are left over after filling the crates:

```inko
loose_apples(apples: 100, per_crate: 24)
# => 4
```

## 3. Work out how many crates to bring

The pickers bring empty crates into the field, and a part-filled crate still needs a crate. Define the
`crates_needed` method, which returns how many crates are needed to hold all the apples:

```inko
crates_needed(apples: 100, per_crate: 24)
# => 5
```

## 4. Work out the average weight

Define the `average_weight` method, which takes the total weight of a basket in grams and the number of apples in
it, and returns the average weight of one apple in grams, as a `Float`:

```inko
average_weight(grams: 1000, apples: 8)
# => 125.0
```

## 5. Price a sale

Define the `sale_price` method, which takes a weight in kilograms and a price per kilogram, both `Float`, and
returns the price rounded to two decimals (whole cents):

```inko
sale_price(kilograms: 2.5, per_kilogram: 3.99)
# => 9.98
```
