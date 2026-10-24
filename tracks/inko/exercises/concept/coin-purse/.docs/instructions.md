# Instructions

In the kingdom of Varn, money comes in gold, silver and copper coins: a gold coin is worth 10 silver coins, and a
silver coin is worth 10 copper coins. Merchants are tired of converting by hand, so the royal treasury wants a
`Coins` type that does the sums with ordinary operators. The stub defines `Coins`, which stores its amount in
copper; implement its operators and traits.

```inko
Coins.new(gold: 1, silver: 2, copper: 3).in_copper
# => 123
```

## 1. Add amounts

Implement `+`, which returns the two amounts together:

```inko
(Coins.new(gold: 1, silver: 2, copper: 3) + Coins.new(gold: 0, silver: 5, copper: 9)).in_copper
# => 182
```

## 2. Pay an amount

Implement `-`, which returns this amount minus the other:

```inko
(Coins.new(gold: 2, silver: 0, copper: 0) - Coins.new(gold: 0, silver: 3, copper: 5)).in_copper
# => 165
```

## 3. Buy several of a kind

Implement `*` with an `Int`, which returns the amount that many times:

```inko
(Coins.new(gold: 0, silver: 2, copper: 5) * 3).in_copper
# => 75
```

## 4. Compare amounts for equality

Implement `==`: two amounts are equal when they're worth the same, whatever the coins:

```inko
Coins.new(gold: 1, silver: 0, copper: 0) == Coins.new(gold: 0, silver: 10, copper: 0)
# => true
```

## 5. Order amounts

Implement `cmp`, which tells whether this amount is worth less than, the same as, or more than another. That also
makes `<`, `>` and sorting work:

```inko
Coins.new(gold: 0, silver: 9, copper: 9).cmp(Coins.new(gold: 1, silver: 0, copper: 0))
# => Ordering.Less
```

## 6. Write the amount down

Implement `to_string`, which shows the amount in the fewest coins possible:

```inko
Coins.new(gold: 0, silver: 12, copper: 15).to_string
# => '1g 3s 5c'
```
