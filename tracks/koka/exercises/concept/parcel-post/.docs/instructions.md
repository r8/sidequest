# Instructions

The village post office is replacing its handwritten price list with a till, and Agnes, the postmistress, has
asked you to program it.

## 1. Price the postage

Postage is 5 euros plus 2 euros per kg. Express delivery doubles the price, but most parcels are sent standard.
Define the `postage` function: it takes the weight in kg and, optionally, whether the parcel goes by express
(standard when left out), and returns the postage in euros.

```koka
postage(3)
// => 11
postage(3, express = True)
// => 22
```

## 2. Spot oversized parcels

A parcel's _girth_ is the distance around it: twice its width plus twice its height. A parcel is oversized when
its length plus its girth is more than 300 cm. Define the `is-oversize` function: it takes the length, width and
height in cm and returns whether the parcel is oversized.

```koka
is-oversize(120, 50, 40)
// => True
```

## 3. Work out the full cost

An oversized parcel costs a 15 euro surcharge on top of its postage. Define the `parcel-cost` function: it takes
the weight, the length, width and height, and optionally whether the parcel goes by express (standard when left
out), and returns what sending it costs.

```koka
parcel-cost(2, 30, 20, 10)
// => 9
parcel-cost(5, 150, 50, 50, express = True)
// => 45
```

## 4. Refund the overpaid

Customers who weigh their own standard parcels sometimes pay too much. Define the `refund` function: it takes
what the customer paid and the parcel's weight, and returns how much they overpaid for standard postage — or 0
if they did not overpay.

```koka
refund(10, 1)
// => 3
```
