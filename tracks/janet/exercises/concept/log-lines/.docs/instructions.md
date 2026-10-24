# Instructions

The control room of the city's tram network collects a log from every tram, every switch and every stop.
Each line looks like this:

```text
[WARN] 14:02 tram 7: door sensor stuck
```

— a level in square brackets (`INFO`, `WARN` or `ERROR`), a time, and a message.
When something goes wrong, the dispatcher on duty, Femi, scrolls through thousands of these.
Help her with a few PEG-based tools.

## 1. Read the level

Define the function `level` that takes a line and returns its level as a keyword — `:info`, `:warn` or `:error` — or `nil` if the line does not start with one of the three levels in brackets.

```janet
(level "[WARN] 14:02 tram 7: door sensor stuck")
# => :warn
(level "WARN: no brackets")
# => nil
```

## 2. Read the time

Define the function `timestamp` that takes a line and returns its time as a tuple of the hours and minutes, both numbers.
The time is the two digits, a colon and two more digits that follow the level and a space.

```janet
(timestamp "[INFO] 06:45 tram 12: depot exit")
# => [6 45]
```

## 3. List the trams

Define the function `trams` that takes the text of a log — any number of lines — and returns an array of the tram numbers mentioned in it, as strings, in order.
A tram is mentioned as the word `tram`, a space and its number.

```janet
(trams "[INFO] 06:45 tram 12: depot exit\n[WARN] 14:02 tram 7: door sensor stuck")
# => @["12" "7"]
```

## 4. Redact badge numbers

Drivers' badge numbers must not leave the control room.
Define the function `redact` that takes a line and returns it as a string with every `badge` followed by a space and digits replaced by `badge [redacted]`.

```janet
(redact "[INFO] 07:10 tram 3: driver badge 4471 on duty")
# => "[INFO] 07:10 tram 3: driver badge [redacted] on duty"
```

## 5. Find the first error

Define the function `first-error` that takes the text of a log and returns the position in the text where the first `[ERROR]` line starts, or `nil` if there is none.

```janet
(first-error "[INFO] 06:45 ok\n[ERROR] 06:50 tram 4: power lost")
# => 16
```
