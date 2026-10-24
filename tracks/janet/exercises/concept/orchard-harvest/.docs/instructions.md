# Instructions

Every autumn the Halvorsen family picks the apples in their hillside orchard and sells them at the farm gate.
Apples go into wooden crates that hold exactly 24 apples each, and whatever does not fill a crate is sold loose from a basket.
This year the family wants a few small functions to do the sums while they pick.

## 1. Count the full crates

Define the function `crates` that takes the number of apples picked and returns how many crates can be filled completely.

```janet
(crates 100)
# => 4
```

## 2. Count the loose apples

Define the function `leftover` that takes the number of apples picked and returns how many are left over after filling as many crates as possible.

```janet
(leftover 100)
# => 4
```

## 3. Count the crates to bring

The family would rather not carry loose apples down the hill, so they bring enough crates for every apple, even if the last one is only partly full.
Define the function `crates-needed` that takes the number of apples and returns how many crates that takes.

```janet
(crates-needed 100)
# => 5
```

## 4. Calculate the average weight

Define the function `average-weight` that takes the total weight of a batch of apples in grams and the number of apples in it, and returns the average weight of one apple in grams.
The average does not have to be a whole number.

```janet
(average-weight 450 4)
# => 112.5
```

## 5. Round prices to the cent

Prices at the farm gate are worked out per kilogram, which leaves long fractions.
Define the function `round-to-cents` that takes an amount of money and rounds it to two decimal places.

```janet
(round-to-cents 1.234)
# => 1.23
```
