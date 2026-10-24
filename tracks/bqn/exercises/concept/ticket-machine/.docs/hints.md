# Hints

## General

- The [blocks documentation](https://mlochbaum.github.io/BQN/doc/block.html) covers statements, local names
  and headers.
- The [lexical scoping documentation](https://mlochbaum.github.io/BQN/doc/lexical.html) explains which names a
  block can see and change.

## 1. Calculate the fare

- A header can name the parts of the right argument: `{zones 𝕊 adults‿children: …}`.
- Compute the adult fare once, in a local name, and use it twice.

## 2. Give change

- The change is the difference; `⌊` and `|` split it into twos and ones.
- The result is a list of two numbers.

## 3. Check a ticket

- Destructure the left argument in the header.
- Two comparisons joined with `∧`; parenthesise the left one.

## 4. Print the timetable

- `↕` gives the numbers of the departures, counting from zero.

## 5. Apply the discounts

- Name the three parts in the header, then change `fare` step by step with `÷↩` and `-↩`.
- Dividing by `1 + senior` halves the fare only for seniors.
- The larger of two numbers keeps the fare from dropping too low.
