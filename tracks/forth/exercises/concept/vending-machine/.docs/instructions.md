# Instructions

The vending machine on platform 4 has a new controller, and you are writing its firmware.
Things go wrong in a vending machine all the time — coins run short, slots run empty, passengers press buttons that do not exist — and the firmware has to say so and recover.

The stub defines the machine's own error codes, and the variable `credit`, the money inserted so far:

```forth
1 constant sold-out
2 constant not-enough-money
variable credit
```

## 1. Give change

Define `change ( price paid -- change )`, the change due when `paid` pence are given for an item costing `price`.
When `paid` is less than `price`, throw `not-enough-money`.

```forth
150 200 change   \ leaves 50
150 100 change   \ throws not-enough-money
```

## 2. Take an item from a slot

Define `take-one ( stock -- stock' )`, the number of items left after taking one.
When the slot is empty, throw `sold-out`.

```forth
3 take-one   \ leaves 2
0 take-one   \ throws sold-out
```

## 3. Check the slot number

The machine has slots 1 to 12.
Define `check-slot ( n -- n )`, which leaves a valid slot number as it is and throws -24 for any other.

```forth
7 check-slot    \ leaves 7
13 check-slot   \ throws -24
```

## 4. Refund when the money is short

Define `change-or-refund ( price paid -- coins )`: the change, as `change` gives it, or, when `change` throws `not-enough-money`, all the money paid, returned to the passenger.
Any other code is passed on.

```forth
150 200 change-or-refund   \ leaves 50
150 100 change-or-refund   \ leaves 100
```

## 5. Return the credit after a fault

Define `guarded ( xt -- code )`: run `xt`, a word with stack effect `( -- )`, and leave 0 if it finishes, or the code it throws.
When it throws, the passenger's money is returned: set `credit` back to 0.

```forth
' noop guarded         \ leaves 0, credit unchanged
' some-fault guarded   \ leaves the fault's code, credit is 0
```
