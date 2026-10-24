# Instructions

Ola maintains the weather stations on the hills around her town: a roof station on the town hall, one in a
cellar, one on each summit. The code that turns readings into reports should not care whether the numbers come
from real sensors or from a table typed in for a test, so the readings are an effect:

```koka
pub effect sensor
  fun reading(station : string) : int

pub effect val units : string
```

`reading` gives a station's temperature, a whole number, and `units` the unit suffix to print, such as `"C"`.
Both are declared for you in the stub.

## 1. Compare two stations

Define the `difference` function: it takes the names of two stations and returns the reading of the first minus
the reading of the second.

```koka
difference("roof", "cellar")
// => 6, when the roof reads 21 and the cellar 15
```

## 2. Average the readings

Define the `average` function: it takes a list of station names and returns the average of their readings,
rounded down. A list without stations averages 0.

```koka
average(["roof", "cellar"])
// => 18
```

## 3. Report a station

Define the `report` function: it takes a station name and returns `"<station>: <reading><units>"`.

```koka
report("roof")
// => "roof: 21C", when the units are "C"
```

## 4. Read from a table

For testing, Ola types readings into a table. Define the `with-readings` function: it takes a list of
`(station, reading)` pairs and an action, and runs the action with every `reading` answered from the table. A
station missing from the table reads 0.

```koka
with-readings([("roof", 21), ("cellar", 15)]) { difference("roof", "cellar") }
// => 6
```

## 5. Calibrate the sensors

Some sensors read low. Define the `with-offset` function: it takes an offset and an action, and runs the action
with every reading increased by the offset, taking the readings themselves from the `sensor` handler outside it.

```koka
with-readings([("roof", 21)]) { with-offset(2) { reading("roof") } }
// => 23
```
