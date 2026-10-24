# Instructions

The overnight train from Lisbon to Vienna leaves at nine in the evening, and the conductor, Tomás, is tired of
working out the rules on paper. Help him with a few functions for his ticket machine.

## 1. Tell night from day

The quiet hours on the train run from 22:00 until 6:00. Define the `is-night` function: it takes an hour from 0 to
23 and returns whether that hour is a night hour.

```koka
is-night(23)
// => True
is-night(6)
// => False
```

## 2. Decide who may board

A passenger may board with a ticket or with a rail pass, but never if they have been banned from the train.
Define the `can-board` function: it takes whether the passenger has a ticket, whether they have a pass, and
whether they are banned, and returns whether they may board.

```koka
can-board(False, True, False)
// => True
```

## 3. Work out the fare

Children under 4 travel free, children under 16 pay 20 euros, passengers of 65 and over pay 25 euros, and
everyone else pays 40 euros. Define the `fare` function: it takes the passenger's age and returns the fare.

```koka
fare(10)
// => 20
```

## 4. Price the ticket

A sleeper berth costs 30 euros on top of the fare. Define the `ticket-price` function: it takes the passenger's
age and whether they want a sleeper berth, and returns the price of the ticket.

```koka
ticket-price(30, True)
// => 70
```
