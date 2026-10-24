# Instructions

The Hardanger weather station sends weather balloons up into the sky every morning. Each balloon is its own
process, measuring the altitude as it climbs, and the station asks every balloon for the highest altitude it
reached. With a dozen balloons in the air, asking them one by one is too slow, so the station asks them all at once
and collects the answers as they come in. The stub defines the `Balloon` process; write its `peak` message and the
station's methods.

## 1. Report the peak

Define the `peak` message of `Balloon`, which replies with the highest altitude among the balloon's readings, or
`0` when it has none:

```inko
await Balloon.new(recover [300, 1200, 800]).peak
# => 1200
```

## 2. Send a request

Define the `request` method, which asks a balloon for its peak and returns the future of the answer, without
waiting for it:

```inko
let future = request(balloon)

future.get
# => 1200
```

## 3. Ask every balloon

Define the `peaks` method, which asks every balloon in a list for its peak (sending all the requests before waiting
for any answer) and returns the peaks in the order of the list:

```inko
peaks([first, second, third])
# => [1200, 5400, 700]
```

## 4. Find the record

Define the `record` method, which returns the highest peak of all the balloons, or `0` when there are none:

```inko
record([first, second, third])
# => 5400
```

## 5. Stop waiting

Balloons drift out of radio range. Define the `listen` method, which waits for a future's value for at most a given
time, returning the value in a `Some`, or `None` if it didn't arrive in time:

```inko
listen(request(balloon), Duration.from_secs(5))
# => Option.Some(1200)
```
