# Instructions

Ottilie's chocolate factory packs pralines into boxes, and the boxes travel to the shipping room on a conveyor belt.
The belt never delivers everything at once: whoever is at the end takes one box, and only then does the next one roll up.
Ottilie wants a model of the belt for the shipping room's new software, and fibers fit it exactly.

## 1. Load the belt

Define the function `make-belt` that takes an array of boxes and returns a fiber that yields them one at a time, in order.

```janet
(def belt (make-belt @["truffles" "pralines"]))
(resume belt)
# => "truffles"
```

## 2. Take the next box

Define the function `next-box` that takes a belt and returns the next box on it, or `nil` once the belt is empty.
Calling it again on an empty belt must keep returning `nil`.

```janet
(def belt (make-belt @["truffles"]))
(next-box belt)
# => "truffles"
(next-box belt)
# => nil
(next-box belt)
# => nil
```

## 3. Unload the rest

Define the function `unload` that takes a belt and returns an array of all the boxes still on it.

```janet
(def belt (make-belt @["truffles" "pralines" "nougat"]))
(next-box belt)
(unload belt)
# => @["pralines" "nougat"]
```

## 4. Print the labels

Every box gets a label: a prefix, a dash and a number counting up from 1.
Define the function `labels` that takes a prefix and returns a fiber that yields the labels for as many boxes as anyone asks for.

```janet
(def printer (labels "XMAS"))
(resume printer)
# => "XMAS-1"
(resume printer)
# => "XMAS-2"
```

## 5. Weigh the shipment

At the end of the belt is a scale that keeps a running total.
Define the function `make-scale` that takes no arguments and returns a fiber; each time it is resumed with a box's weight, it returns the total weight of all boxes weighed so far.

```janet
(def scale (make-scale))
(resume scale 250)
# => 250
(resume scale 500)
# => 750
```
