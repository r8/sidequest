# Instructions

The Brightwater toy factory builds wooden trains on an assembly line. Each station on the line is a function
that takes a toy and returns it worked on — painted, varnished, boxed. Some stations can fail: the paint robot
throws an exception when it runs dry. The line controller you are writing must work with any station, whatever
its effects.

## 1. Run a station over a batch

Define the `process-all` function: it takes a list of items and a station, and returns the list of the station's
results, in order. If the station throws, so does `process-all`.

```koka
process-all([1, 2, 3], fn(n) n * 10)
// => [10, 20, 30]
```

## 2. Send an item down the line

Define the `pipeline` function: it takes an item and a list of stations, and passes the item through every
station in turn, the first station first.

```koka
pipeline("train", [fn(s) s ++ " painted", fn(s) s ++ " boxed"])
// => "train painted boxed"
```

## 3. Count what passes inspection

Define the `count-passing` function: it takes a list of items and a check, and returns how many items the check
accepts.

```koka
count-passing([3, -1, 4], fn(n) n > 0)
// => 2
```

## 4. Inspect a wheel

Every train needs wheels between 10 and 20 millimetres wide, inclusive. Define the `inspect-wheel` function: it
takes a width and returns it unchanged if it is within the limits, and throws the exception `"defective wheel"`
otherwise.

```koka
inspect-wheel(12)
// => 12
```

## 5. Stop at the first defect

Checking is slow, so the line stops at the first item that fails. Define the `first-defect` function: it takes a
list of items and a check, and returns the first item the check rejects, or `Nothing` if every item passes. It
must not check any item after the first defect.

```koka
first-defect([3, -1, 4, -5], fn(n) n > 0)
// => Just(-1)
```
