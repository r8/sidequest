# Instructions

The town's new multi-storey car park opens next week, and its parking system still has no software. You have
offered to write the rules in BQN: what each vehicle pays, which floor it may use, and what the sign at the
entrance shows.

## 1. Look up the hourly rate

Write the function `Rate`. It takes the kind of vehicle as a string and returns its hourly rate in coins:
`"motorbike"` 1, `"car"` 2, `"van"` 3, and 4 for anything else.

```bqn
Rate "van"
# ⇒ 3
```

## 2. Calculate the fee

Parking for a car costs 2 coins an hour, but the first hour is free and a stay never costs more than 20 coins.
Write the function `Fee`. It takes the whole number of hours parked and returns the fee.

```bqn
Fee 4
# ⇒ 6
```

## 3. Send vehicles to the right floor

The upper floors have low ceilings. Vehicles taller than 2.2 metres must park on the `"ground"` floor, those
taller than 1.6 metres on the `"middle"` floor, and everything else on the `"roof"`. Write the function `Floor`.
It takes a vehicle's height in metres and returns the floor's name.

```bqn
Floor 1.5
# ⇒ "roof"
```

## 4. Accept vouchers

Write the function `Charge`. Called with one argument, the hours parked, it returns the same fee as `Fee`.
Called with a voucher code as its left argument, `"HALF"` halves the fee and `"FREE"` makes it 0, while any
other code is ignored.

```bqn
Charge 4
# ⇒ 6
"HALF" Charge 4
# ⇒ 3
```

## 5. Show the entrance sign

Write the function `Sign`. It takes a list `capacity‿occupied` and returns what the sign shows: the number of
free spaces, or the string `"FULL"` when there are none. On busy days the car park is overbooked, so
`occupied` can be more than `capacity`; the sign then shows `"FULL"` too.

```bqn
Sign 120‿85
# ⇒ 35
Sign 120‿121
# ⇒ "FULL"
```
