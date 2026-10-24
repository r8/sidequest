# Hints

## General

- [General loops](https://gforth.org/manual/General-Loops-Tutorial.html) in the Gforth tutorial, and [Simple loops](https://gforth.org/manual/Simple-Loops.html) in the reference.
- Write the stack at `begin` as a comment; every pass must leave it in that shape.

## 1. Paint the race numbers

- Dividing by 10 removes one digit; count the divisions until nothing is left.
- Every number has at least one digit, so the loop always runs at least once.

## 2. Wait for the trail to dry

- The trail may already be dry, so test before the first halving.
- Keep the count of hours below the trail and the limit.

## 3. Climb the well

- Instead of the height climbed, keep track of the distance still to go.
- The slip only happens on nights when the snail has not reached the top yet.

## 4. Plan the feasts

- Try the square of 1, 2, 3, … until one is larger than the given day.
