# Instructions

The weather station on Bracken Hill reports in numbers: months as 1 to 12, and the rain gauge as a code from 0 to 3.
The station's new logger needs a few words to turn those numbers into something it can record.

## 1. Count the days in a month

Define `days-in-month ( month -- days )` for a year that is not a leap year: February has 28 days; April, June, September and November have 30; the rest have 31.

```forth
2 days-in-month   \ leaves 28
9 days-in-month   \ leaves 30
```

## 2. Read the rain gauge

The gauge reports 0 for no rain, 1 for drizzle, 2 for light rain and 3 for heavy rain, which the logger records as 0, 1, 4 and 16 mm.
Any other code means the gauge is faulty, which the logger records as -1.
Define `rain-mm ( code -- mm )`.

```forth
2 rain-mm   \ leaves 4
7 rain-mm   \ leaves -1
```

## 3. Turn the page

Define `next-month ( month -- month' )`, the month after the given one; after December comes January.

```forth
4 next-month    \ leaves 5
12 next-month   \ leaves 1
```

## 4. Allow for leap years

In a leap year February has 29 days.
Define `month-length ( leap? month -- days )`, where `leap?` is a flag that is true in a leap year.

```forth
true 2 month-length    \ leaves 29
false 2 month-length   \ leaves 28
true 6 month-length    \ leaves 30
```
