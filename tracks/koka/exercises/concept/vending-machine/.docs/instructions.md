# Instructions

The vending machine in the hall of the Larkspur library sells snacks for whole numbers of coins. Its firmware is
being rewritten, and the new version reports problems with exceptions. You are writing the coin logic, and the
parts of the front panel that must never crash.

## 1. Sell an item

Define the `vend` function: it takes the price of an item and the coins paid, and returns the change. If fewer
coins were paid than the price, it throws the exception `"not enough money"`.

```koka
vend(3, 5)
// => 2
```

## 2. Try to sell an item

Define the `try-vend` function: it takes a price and the coins paid, like `vend`, and returns the change in a
`Just`, or `Nothing` if the sale fails.

```koka
try-vend(3, 2)
// => Nothing
```

## 3. Sell or refund

Define the `vend-or-refund` function: it takes a price and the coins paid, and returns the change, or all the coins
paid if the sale fails. It never throws.

```koka
vend-or-refund(3, 2)
// => 2
```

## 4. Show the outcome

Define the `panel-text` function: it takes a price and the coins paid, and returns the text for the panel:
`"change: "` followed by the change, or `"error: "` followed by the exception's message if the sale fails.

```koka
panel-text(3, 2)
// => "error: not enough money"
```

## 5. Sell several items

Define the `vend-all` function: it takes a list of prices and the coins paid, buys the items in order, each from
the change left by the one before, and returns the final change. It throws `"not enough money"` when the coins
run out before the last item.

```koka
vend-all([1, 2], 5)
// => 2
```
