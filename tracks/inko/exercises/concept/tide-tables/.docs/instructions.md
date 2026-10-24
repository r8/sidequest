# Instructions

Harbour master Yusuf measures the height of the water at the harbour wall every hour, in centimetres, and posts
the readings so that skippers know when they can sail in and out. A day's readings are an array of heights, the
first taken at hour 0. Help him read the tide tables.

## 1. Find the high water mark

Define the `highest` method, which returns the highest reading, or `0` when there are no readings:

```inko
highest([120, 180, 260, 210])
# => 260
```

## 2. Count the hours above a level

Define the `hours_above` method, which returns how many readings are at or above a given level:

```inko
hours_above([120, 180, 260, 210], level: 200)
# => 2
```

## 3. Find when a boat can come in

Define the `first_hour_at` method, which returns the hour of the first reading at or above a level, or `-1` when the
water never gets that high:

```inko
first_hour_at([120, 180, 260, 210], level: 200)
# => 2
```

## 4. Plan the readings

On busy days Yusuf takes readings more often. Define the `reading_times` method, which takes the first minute, the
last minute and the interval, and returns the minutes at which to take a reading. The last minute is included when
the interval reaches it exactly:

```inko
reading_times(first: 0, last: 60, every: 20)
# => [0, 20, 40, 60]
```

## 5. Find the longest safe stretch

The ferry needs at least a certain depth to stay in the harbour. Define the `longest_safe_stretch` method, which
returns the length, in hours, of the longest run of consecutive readings at or above a minimum:

```inko
longest_safe_stretch([150, 210, 230, 190, 220, 240, 250, 180], minimum: 200)
# => 3
```
