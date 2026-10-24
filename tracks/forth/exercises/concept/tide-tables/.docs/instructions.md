# Instructions

The harbour master at Port Wenna records the height of the tide every hour, in centimetres above the lowest tide of the year.
A day's readings are an array of cells `( table n )`, the first reading first.
She needs a few words to make sense of them before the fishing fleet goes out.

## 1. Read one reading

Define `tide-at ( table i -- level )`, the reading at index `i`, counting from 0.

```forth
create today 120 , 180 , 240 , 210 , 150 ,
today 2 tide-at   \ leaves 240
```

## 2. Find the high tide

Define `highest ( table n -- level )`, the highest reading.
There is always at least one reading.

```forth
today 5 highest   \ leaves 240
```

## 3. Work out the average

Define `average-level ( table n -- level )`, the average of the readings, rounded down.
There is always at least one reading.

```forth
today 5 average-level   \ leaves 180
```

## 4. Find when the water drops

Boats with a deep keel cannot leave once the water drops below a certain level.
Define `first-below ( table n level -- i )`, the index of the first reading below `level`, or -1 if no reading is below it.

```forth
today 5 200 first-below   \ leaves 0
today 5 100 first-below   \ leaves -1
```

## 5. Correct the gauge

The tide gauge was knocked out of place, and every reading of the day is off by the same amount.
Define `raise-all ( table n amount -- )`, which adds `amount` (which may be negative) to every reading in the array, in place.

```forth
today 5 -20 raise-all
today 0 tide-at   \ leaves 100
```
