# Hints

## General

- [Arrays and records](https://gforth.org/manual/Arrays-and-Records-Tutorial.html) in the Gforth tutorial.
- [Counted loops](https://gforth.org/manual/Counted-Loops.html) in the Gforth manual covers `?do`, `+loop` and `unloop`.

## 1. Read one reading

- Turn the index into a distance in bytes, add it to the address, and fetch.

## 2. Find the high tide

- Start with the first reading and keep the larger of it and each reading in turn.

## 3. Work out the average

- Adding up the readings is a useful word of its own.
- Integer division rounds down for positive numbers.

## 4. Find when the water drops

- This needs the index, so loop over indices rather than addresses.
- Leave the loop and the word as soon as you find a match; what is left on the stack at that point must be just the index.

## 5. Correct the gauge

- `+!` adds to the cell at an address; a loop over addresses gives you each element's address as `i`.
