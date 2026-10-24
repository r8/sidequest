# Instructions

The vending machine in the hall of the swimming pool is old and grumpy, and the new control board you are programming for it should at least be polite.
The machine's slots are a table from a slot code to a table describing what is in it:

```janet
(def machine
  @{"A1" @{:name "Crisps" :price 120 :stock 3}
    "B2" @{:name "Apple" :price 80 :stock 0}})
```

## 1. Dispense a snack

Define the function `dispense` that takes the machine and a slot code, takes one item out of that slot's stock and returns the item's name.
It raises an error when the slot does not exist, with the message `no such slot: <code>`, and when the slot is empty, with the message `sold out: <name>`.

```janet
(dispense machine "A1")
# => "Crisps", and the stock of "A1" is now 2

(dispense machine "C7")
# error: no such slot: C7

(dispense machine "B2")
# error: sold out: Apple
```

## 2. Dispense without complaining

The screen on the front of the machine shows a snack's name, or nothing at all.
Define the function `try-dispense` that takes the machine and a slot code and returns what `dispense` returns, or `nil` when `dispense` raises an error.

```janet
(try-dispense machine "C7")
# => nil
```

## 3. Check the coins

The machine takes coins of 10, 20, 50, 100 and 200 cents.
Define the function `insert-coins` that takes a tuple of coins and returns their total, raising an error with the message `unknown coin` when any of them is not one the machine takes.

```janet
(insert-coins [100 20])
# => 120

(insert-coins [100 25])
# error: unknown coin
```

## 4. Tell the attendant about sold-out slots only

When the attendant restocks the machine, sold-out slots are expected, but any other problem must be reported.
Define the function `restock-check` that takes the machine and a slot code and returns what `dispense` returns, or `:empty` when the slot is sold out.
Every other error must be raised again, unchanged.

```janet
(restock-check machine "B2")
# => :empty

(restock-check machine "C7")
# error: no such slot: C7
```

## 5. Log every attempt

The machine keeps a log of what happened at every press of a button.
Define the function `attempt` that takes a function of no arguments, calls it, and returns `[:ok <result>]` when it succeeded or `[:error <error value>]` when it raised an error.

```janet
(attempt (fn [] (dispense machine "A1")))
# => [:ok "Crisps"]

(attempt (fn [] (dispense machine "C7")))
# => [:error "no such slot: C7"]
```
