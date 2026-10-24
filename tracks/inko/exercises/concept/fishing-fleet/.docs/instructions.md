# Instructions

The harbour of Skerrivik sends its fishing fleet out every morning. The harbour master has a list of fishing grounds
to cover today, and rather than assigning grounds to boats, she puts the jobs on a board: whichever boat is free
takes the next ground, fishes it, and reports its catch. Every boat is a process, and the board and the reports are
channels. The stub provides `catch_at`, which tells how many kilograms of fish a boat brings back from a ground.

## 1. Put up the jobs

Define the `jobs` method, which returns a channel holding one job (the name of the ground) for each ground in the
list, in order:

```inko
let work = jobs(['north', 'reef'])

work.receive
# => 'north'
```

## 2. Send a boat out

Define the `fish` message of `Boat`. It takes the jobs channel and a channel for catches, then takes jobs one at a
time: for every ground, it sends the catch `(ground, kilograms)` to the catches channel, until it receives the job
`'home'`, when it stops:

```inko
Boat().fish(recover work.clone, recover catches.clone)
```

## 3. Collect the catches

Define the `collect` method, which receives a given number of catches from the catches channel and returns the
total kilograms caught at each ground, as a map:

```inko
collect(catches, 3)
# => a map with 'reef' => 90 and 'north' => 120
```

## 4. Run the fleet

Define the `fleet_catch` method, which takes the list of grounds and the number of boats, sends that many boats out
to fish all the grounds, tells every boat to come home once the work is done, and returns the total kilograms caught
at each ground:

```inko
fleet_catch(['north', 'reef', 'bank', 'reef'], boats: 3)
# => a map with 'north' => 120, 'reef' => 90 and 'bank' => 80
```
