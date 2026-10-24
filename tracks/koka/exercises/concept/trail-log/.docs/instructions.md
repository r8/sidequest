# Instructions

The Ridgeway Ramblers keep a log of every hike. For each hike they note the length of each leg in kilometres,
from one waymark to the next, and the altitude in metres at every waymark. The club secretary wants a few
figures worked out from the log for the newsletter.

## 1. Add up the distance

Define the `total-distance` function: it takes the legs of a hike and returns the total distance walked.

```koka
total-distance([4, 7, 3])
// => 14
```

## 2. Find the longest leg

Define the `longest-leg` function: it takes the legs of a hike and returns the longest one, or `0` for a hike
with no legs.

```koka
longest-leg([4, 7, 3])
// => 7
```

## 3. Measure the climb

Define the `total-climb` function: it takes the altitudes at the waymarks, in order, and returns the total
height climbed — the sum of every rise from one waymark to the next. Descents do not count.

```koka
total-climb([100, 150, 120, 200])
// => 130
```

## 4. Plan the waymarks

The club is marking a new trail. Define the `waymarks` function: it takes the length of the trail in whole
kilometres and returns the kilometre numbers to paint on the waymarks, counting down to the finish: one per
kilometre, from the length down to `1`. A trail of `0` kilometres needs none.

```koka
waymarks(4)
// => [4, 3, 2, 1]
```
