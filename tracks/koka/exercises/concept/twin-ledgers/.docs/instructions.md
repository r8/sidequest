# Instructions

Pip runs a small bicycle repair shop with two ledgers: one for the till by the counter and one for the safe in
the back. At the end of each day the takings go from the till to the safe, leaving a float in the till for the
next morning. Pip wants a program that keeps both ledgers straight.

The `ledger` effect is declared in the stub as a named effect.

## 1. Open a ledger

Define `open-ledger`: it takes an opening balance and an action, creates a named handler for `ledger` whose
balance starts at the opening balance, and returns the result of running the action with that handler.

```koka
open-ledger(100, fn(l) { l.record(50); l.balance })
// => 150
```

## 2. Transfer money

Define `transfer`: it takes the ledger to move money from, the ledger to move it to and the amount, and records
the move in both.

```koka
open-ledger(100, fn(till) open-ledger(0, fn(safe) { transfer(till, safe, 30); (till.balance, safe.balance) }))
// => (70, 30)
```

## 3. Bank the takings

Define `bank-takings`: it takes the till, the safe and the float to leave in the till, moves everything in the
till above the float into the safe, and returns how much it moved. When the till holds no more than the float,
nothing moves.

```koka
open-ledger(180, fn(till) open-ledger(200, fn(safe) bank-takings(till, safe, 50)))
// => 130
```

## 4. Audit the ledgers

Define `audit`: it takes a list of ledgers and returns the sum of their balances.

```koka
open-ledger(10, fn(a) open-ledger(20, fn(b) audit([a, b])))
// => 30
```

## 5. Close the books

Define `closing-balance`: it works like `open-ledger`, but returns the action's result paired with the ledger's
balance when the action has finished.

```koka
closing-balance(10, fn(l) { l.record(5); "ok" })
// => ("ok", 15)
```
