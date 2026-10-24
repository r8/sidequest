# Hints

## General

- [The return stack](https://gforth.org/manual/Return-Stack-Tutorial.html) in the Gforth tutorial, and the [reference](https://gforth.org/manual/Return-stack.html).
- Every value you move to the return stack must come back before the word ends.

## 1. Combine two claims

- Bring the two bag counts together and add them; then park the result while you add the coats.

## 2. Scale a claim

- `n` is needed twice; copy it so each count gets one.
- Park one product while you compute the other.

## 3. Shift the hooks

- With the last item parked, the other three need only one shuffle.

## 4. Find the bigger claim

- Park the second claim as a pair while you total the first, and copy it back to total it too.
- Whichever claim wins, both pairs must leave the return stack.
