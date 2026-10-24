# Hints

## General

- The Janet documentation's [flow control](https://janet-lang.org/docs/flow.html) page covers `if`, `when`, `cond` and `case`.
- [Special forms](https://janet-lang.org/docs/specials.html) describes `if` and `do` exactly.

## 1. Check whether the market is open

- The open hours wrap around midnight, so they are two ranges: one in the evening and one after midnight.
- `or` combines two comparisons; comparisons already return booleans.

## 2. Check who may enter

- Either the visitor is old enough, or they came with an adult.

## 3. Work out a stall's fee

- Comparing one value against a list of constants is what `case` is for.
- Remember the default for any other size.

## 4. Pick the lantern colour

- `cond` tries its conditions in order, so each one can assume the earlier ones were false.

## 5. Call last orders

- There is no else-branch here, and the result should be `nil` when the condition is false.
