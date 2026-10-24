# Instructions

You've started a weekend job at a paint shop, where any colour can be mixed to order. The owner wants a set of
wall charts for the counter: what every combination costs and what it is called, so that customers stop asking
the same questions all day.

## 1. Price every base with every tint

A tin of paint is a base plus a tint. Write the function `Prices`. Its left argument is the list of base prices
and its right argument the list of tint prices; it returns a table with one row per base and one column per
tint, holding the price of each mix.

```bqn
20‿25 Prices 3‿5‿8
# ⇒ a 2×3 table: 23 25 28 / 28 30 33
```

## 2. Price every tin size

Write the function `Costs`. Its left argument is the list of tin sizes in litres and its right argument the
price per litre of each paint; it returns a table with one row per tin size and one column per paint, holding
the price of that tin of that paint.

```bqn
1‿2.5 Costs 8‿12
# ⇒ a 2×2 table: 8 12 / 20 30
```

## 3. Name every mix

Write the function `MixNames`. Its left argument is a list of shade words and its right argument a list of
colours; it returns a table with one row per shade and one column per colour, holding the name of the mix: the
shade, a space, and the colour.

```bqn
"pale"‿"deep" MixNames "blue"‿"red"‿"green"
# ⇒ a 2×3 table: "pale blue" "pale red" "pale green" / "deep blue" "deep red" "deep green"
```

## 4. Match the orders to the shelf

Each tin on the shelf is labelled with a one-letter code. Write the function `Matches`. Its left argument is the
string of codes on the shelf and its right argument the string of codes customers ordered; it returns a table
with one row per tin on the shelf and one column per order, holding 1 where the tin matches the order and 0
elsewhere.

```bqn
"RGB" Matches "BRR"
# ⇒ a 3×3 table: 0 1 1 / 0 0 0 / 1 0 0
```
