# Instructions

Every summer evening the old harbour turns into a night market: food stalls, paper lanterns, music until late.
This year the organisers are replacing the hand-painted signs at the gate with a little computer, and they need the rules written down as code.

## 1. Check whether the market is open

The market opens at 18:00 and closes at 2:00 the next morning.
Define the function `open?` that takes the hour of the day (an integer from 0 to 23) and returns `true` when the market is open during that hour and `false` otherwise.

```janet
(open? 20)
# => true
(open? 12)
# => false
```

## 2. Check who may enter

Visitors aged 16 and over may walk in on their own; younger visitors may enter only with an adult.
Define the function `can-enter?` that takes the visitor's age and a boolean saying whether they came with an adult, and returns `true` if they may enter and `false` otherwise.

```janet
(can-enter? 12 true)
# => true
(can-enter? 12 false)
# => false
```

## 3. Work out a stall's fee

Stalls come in three sizes: `"small"` costs 10 coins a night, `"medium"` 15 and `"large"` 25.
Any other size is not rented out, so its fee is 0.
Define the function `stall-fee` that takes the size and returns the fee.

```janet
(stall-fee "medium")
# => 15
```

## 4. Pick the lantern colour

A lantern above the gate shows how busy the market is: `"green"` for fewer than 50 visitors, `"amber"` for fewer than 200, and `"red"` otherwise.
Define the function `lantern-color` that takes the number of visitors inside and returns the colour.

```janet
(lantern-color 120)
# => "amber"
```

## 5. Call last orders

At 1:00 the gate announces `"Last orders!"`; at any other hour it stays quiet.
Define the function `closing-call` that takes the hour and returns the announcement during that hour and `nil` otherwise.

```janet
(closing-call 1)
# => "Last orders!"
(closing-call 22)
# => nil
```
