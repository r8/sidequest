# Instructions

The Rialto is a tiny cinema with a single row of seats, and Mr. Okafor sells every ticket himself from a paper
plan. Now that the queue reaches the street, he wants a booking system. A row is a `vector<bool>`, one element
per seat, numbered from `0`: `True` means the seat is booked.

## 1. Set out an empty row

Define the `empty-row` function: it takes the number of seats and returns a row in which no seat is booked.

```koka
empty-row(3).list
// => [False, False, False]
```

## 2. Price the seats

Seats further from the screen cost more: seat `i` costs the base price plus `i`. Define the `seat-prices`
function: it takes the number of seats and the base price and returns a `vector<int>` of every seat's price.

```koka
seat-prices(4, 10).list
// => [10, 11, 12, 13]
```

## 3. Check a seat

Define the `is-free` function: it takes a row and a seat number and returns whether that seat exists and is not
booked. A seat number outside the row, negative or too large, is never free.

```koka
empty-row(3).is-free(1)
// => True
empty-row(3).is-free(5)
// => False
```

## 4. Book a seat

Define the `book` function: it takes a row and a seat number and returns the row with that seat booked. Booking a
seat past the end of the row throws `index out of bounds`.

```koka
empty-row(3).book(1).list
// => [False, True, False]
```

## 5. Count the free seats

Define the `free-count` function: it takes a row and returns how many of its seats are free.

```koka
empty-row(3).book(1).free-count
// => 2
```
