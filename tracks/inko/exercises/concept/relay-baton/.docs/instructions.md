# Instructions

Saturday is the Riverside Relay: teams of runners race around the park, passing a baton from one runner to the
next. There is exactly one baton per team, and only one runner can hold it at a time, which makes it a perfect fit
for Inko's ownership. The stub defines the `Baton` type; add the fields of `Runner` and write its methods.

## 1. Take the baton

Define the static `new` method, which returns a runner without a baton, the `take` method, which gives the runner a
baton to hold, and the `holding?` method:

```inko
let ada = Runner.new('Ada')

ada.take(Baton.new('Red'))
ada.holding?
# => true
```

## 2. Pass it on

Define the `hand_off` method, which passes the runner's baton on to another runner and records the handoff on the
baton (with its `passed` method). A runner without a baton has nothing to pass on:

```inko
let bo = Runner.new('Bo')

ada.hand_off(bo)
ada.holding?
# => false
bo.holding?
# => true
```

## 3. Check the colours

Define the `team` method, which returns the team of the baton the runner holds, without taking the baton away, or
`'no team'`:

```inko
bo.team
# => 'Red'
```

## 4. Finish the race

When a runner is done, they leave the race and hand their baton (if any) to the judges. Define the `retire` method,
which consumes the runner and returns the baton they held:

```inko
bo.retire.map(fn (baton) { baton.handoffs })
# => Option.Some(1)
```

## 5. Count the laps

The judges need a lap counter. Define the `lap_counter` method, which returns a closure; every call of the closure
counts one more lap and returns the number of laps so far:

```inko
let laps = lap_counter

laps.call
# => 1
laps.call
# => 2
```
