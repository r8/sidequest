# Instructions

The hiking club has put a small weather station on every summit around the valley. Each one measures the
temperature now and then and keeps a list of its readings, in degrees Celsius. You're writing the `Station` type
the club's website will use.

The stub defines the `Station` type without any fields: add the fields you need.

## 1. Set up a station

Define the static `new` method, which takes the station's name and returns a station without any readings, and the
`name` method, which returns the name:

```inko
let station = Station.new('Ridge Hut')

station.name
# => 'Ridge Hut'
```

## 2. Record readings

Define the `record` method, which adds a reading, and the `count` method, which returns how many readings the
station has:

```inko
station.record(12.5)
station.record(9.0)
station.count
# => 2
```

## 3. Get the latest reading

Define the `latest` method, which returns the most recent reading, or `None` when there are no readings yet:

```inko
station.latest
# => Option.Some(9.0)
```

## 4. Work out the average

Define the `average` method, which returns the average of the readings, rounded to one decimal, or `0.0` when
there are no readings:

```inko
station.average
# => 10.8
```

## 5. Compare two stations

Define the `warmer_than?` method, which takes another station and returns whether this station's average is higher:

```inko
station.warmer_than?(Station.new('Summit'))
# => true
```

## 6. Rename a station

Stations are sometimes renamed after the club's members. Define the `rename` method, which gives the station a new
name:

```inko
station.rename('Eagle Hut')
station.name
# => 'Eagle Hut'
```
