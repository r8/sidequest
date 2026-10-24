# Instructions

Rosa's bakery is famous for its rolls, and the orders keep getting bigger. She bakes them on trays that hold 12
rolls each, and she wants a few functions to plan her mornings.

## 1. Count the trays

Define the `trays-needed` function: it takes the number of rolls ordered and returns how many trays Rosa needs.
A tray that is only partly full still counts.

```koka
trays-needed(30)
// => 3
```

## 2. Count the empty places

Rosa fills the empty places on her trays with rolls for the shop window. Define the `spare-places` function: it
takes the number of rolls ordered and returns how many places are left empty on the trays of task 1.

```koka
spare-places(30)
// => 6
```

## 3. Weigh the flour

Each roll takes 0.125 kg of flour. Define the `flour-kg` function: it takes the number of rolls and returns the
kilograms of flour they need, as a `float64`.

```koka
flour-kg(10)
// => 1.25
```

## 4. Work out the daily average

Define the `daily-average` function: it takes the number of rolls sold and the number of days they were sold
in, and returns the average number of rolls sold per day, as a `float64`.

```koka
daily-average(25, 2)
// => 12.5
```

## 5. Price an order

A roll costs 0.75 euros, and Rosa only takes whole euros, rounding the total up. Define the `order-price`
function: it takes the number of rolls and returns the price in whole euros.

```koka
order-price(5)
// => 4
```
