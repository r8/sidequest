# Instructions

The survey ship _Long Haul_ keeps its log in kilometres, and its distances have long outgrown a single cell.
Help the navigator, Ines, with words that work in double-cell numbers.
Use 9 460 730 472 581 km for one light year.

## 1. Convert light years

Define `light-years>km ( ly -- d )`, the distance in kilometres, as a double, of a whole number of light years.

```forth
2537000 light-years>km d.   \ prints 24001873208937997000 (the Andromeda galaxy)
```

## 2. Convert to metres

The engineers want distances in metres.
Define `km>metres ( d-km -- d-m )`.

```forth
5. km>metres d.   \ prints 5000
```

## 3. Plan a round trip

Define `round-trip ( d -- d' )`, the distance there and back.

```forth
384400. round-trip d.   \ prints 768800
```

## 4. Compare two destinations

Define `farther? ( d1 d2 -- flag )`, true when the first distance is strictly greater than the second.

```forth
2537000 light-years>km  4 light-years>km  farther?   \ leaves true
```

## 5. Count the days

The _Long Haul_ covers a fixed number of kilometres a day.
Define `travel-days ( d-km km-per-day -- days )`, the number of whole days a journey takes, leaving out any part of a day left over.
The answer fits in a single cell.

```forth
9460730472581. 25902068371 travel-days   \ leaves 365
```
