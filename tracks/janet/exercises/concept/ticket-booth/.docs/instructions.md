# Instructions

The Lantern Theatre is replacing its old ticket booth.
The old one had a paper roll of numbered tickets, a rubber stamp for discounts and a notebook for the night's sales; the new one is a small program, and you are writing the parts of it.
Each part is made by a function that returns another function, so the theatre can set up a fresh one for every show.

## 1. Hand out numbered tickets

Define the function `make-dispenser` that takes the number of the first ticket and returns a function of no arguments.
Each call of that function returns the next ticket number, starting with the first.

```janet
(def next-ticket (make-dispenser 100))
(next-ticket)
# => 100
(next-ticket)
# => 101
```

## 2. Stamp a discount

Define the function `make-discount` that takes a discount in percent and returns a function that takes a price and returns the price with the discount taken off.

```janet
(def student (make-discount 20))
(student 25)
# => 20
```

## 3. Stop when the show is sold out

Define the function `make-limited-dispenser` that takes the number of the first ticket and how many tickets there are, and returns a function like the one in task 1, except that once every ticket has been handed out it returns `nil`.

```janet
(def matinee (make-limited-dispenser 1 2))
(matinee)
# => 1
(matinee)
# => 2
(matinee)
# => nil
```

## 4. Keep the night's tally

Define the function `make-tally` that takes no arguments and returns a struct of two functions sharing one count of tickets sold, which starts at zero:

- `:sell` takes a number of tickets, adds them to the count and returns the new count;
- `:sold` takes no arguments and returns the count.

```janet
(def tally (make-tally))
((tally :sell) 3)
# => 3
((tally :sell) 2)
# => 5
((tally :sold))
# => 5
```
