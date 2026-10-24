# Instructions

You are writing the checkout for a small grocery delivery service. A basket is a list of prices in cents, one per
item, and the checkout has to answer the same handful of questions about every basket.

## 1. Add up the basket

Write the function `Total`. It takes a basket and returns the sum of its prices. An empty basket costs nothing.

```bqn
Total 250‿120‿399
# ⇒ 769
```

## 2. Find the priciest item

Write the function `MostExpensive`. It takes a non-empty basket and returns its highest price.

```bqn
MostExpensive 250‿120‿399
# ⇒ 399
```

## 3. Check the stock

Before packing, the warehouse checks how many of each item it has left. Write the function `AllInStock`. It takes
the stock counts of the basket's items and returns `1` if every item has at least one left, else `0`.

```bqn
AllInStock 4‿0‿12
# ⇒ 0
```

## 4. Apply the discounts

Discounts are multipliers that stack: `0.5` halves the price, and `0.5‿0.5` takes off three quarters. Write the
function `Discounted`. Its left argument is a price and its right argument a list of discounts; it returns the
price after all of them, which is the full price when there are none.

```bqn
400 Discounted 0.5‿0.5
# ⇒ 100
```

## 5. Print the shopping list

The packers want a single line naming every item. Write the function `PackingList`. It takes a non-empty list of
item names and returns them joined with a comma and a space.

```bqn
PackingList "apples"‿"bread"‿"milk"
# ⇒ "apples, bread, milk"
```

## 6. Total every basket in an order

A family order holds several baskets. Write the function `BasketTotals`. It takes a list of baskets and returns the
total of each one.

```bqn
BasketTotals ⟨250‿120, ⟨⟩, ⟨399⟩⟩
# ⇒ ⟨370, 0, 399⟩
```
