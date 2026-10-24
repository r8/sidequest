# Instructions

The Crooked Chimney bakery has a row of ovens, and every oven is managed by its own process, so that the bakers
can heat one oven while another bakes. The stub defines the `Oven` process type; add its fields and write its
messages. Replies go through a `Promise` passed as the first argument, so callers can use `await`.

## 1. Fire up an oven

Define the static `new` method, which spawns an oven at room temperature (20 degrees) that hasn't baked anything,
and the `temperature` message, which replies with the oven's temperature:

```inko
await Oven.new.temperature
# => 20
```

## 2. Heat an oven

Define the `heat_to` message, which sets the oven's temperature:

```inko
let oven = Oven.new

oven.heat_to(220)
await oven.temperature
# => 220
```

## 3. Bake bread

Define the `bake` message, which bakes a number of loaves and replies with the total number of loaves the oven has
baked so far. An oven below 180 degrees bakes nothing and replies with the error `'too cold'`:

```inko
recover await oven.bake(12)
# => Result.Ok(12)
recover await Oven.new.bake(12)
# => Result.Error('too cold')
```

## 4. Load a tray

Bakers load trays of dough into the oven: a tray is a list of what's on it. Define the `load` message, which takes a
tray (as a unique array, so it can be moved into the oven's process) and replies with the number of items on all the
trays in the oven:

```inko
await oven.load(recover ['rye', 'spelt'])
# => 2
```

## 5. Preheat the ovens

Every morning, all ovens are heated at once. Define the `preheat` method, which sends `heat_to` to every oven in a
list:

```inko
preheat([Oven.new, Oven.new], 230)
```
