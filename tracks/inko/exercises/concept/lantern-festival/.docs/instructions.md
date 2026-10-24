# Instructions

At the end of the summer, the town of Lysholm holds a lantern parade along the river. Every child carries a paper
lantern, and when the parade ends the lanterns go out one by one. The festival committee keeps a log of every
lantern that goes out, and they'd like the program to write that log by itself: whenever a `Lantern` is dropped, it
should add a line to the log it was given. The stub defines `Lantern` and `Parade`; give them destructors and write
the methods.

## 1. Put a lantern out

Implement the `drop` method of `Lantern`'s `Drop` implementation, which adds `'NAME goes out'` to the lantern's log:

```inko
let log = []
let lantern = Lantern.new('Moon', log)

drop(lantern)
log
# => ['Moon goes out']
```

## 2. Light the parade

Add the fields of `Parade`, and define the static `new` method, which takes the log, the `light` method, which
lights a new lantern with the given name (writing to the parade's log) and adds it to the end of the parade, and the
`size` method:

```inko
let parade = Parade.new(log)

parade.light('Moon')
parade.size
# => 1
```

## 3. End the parade

When a parade is dropped, it writes `'the parade is over'` to the log, and then all its lanterns go out, from the
first lit to the last. Implement the `drop` method of `Parade`'s `Drop` implementation:

```inko
parade.light('Star')
drop(parade)
log
# => ['the parade is over', 'Moon goes out', 'Star goes out']
```

## 4. Let a child keep a lantern

Some children take their lantern home. Define the `release` method, which takes the lantern with a given name out of
the parade and returns it, or `None` when there is no such lantern. A released lantern doesn't go out with the
parade, but when it's dropped later:

```inko
let kept = parade.release('Moon')
```

## 5. Snuff a lantern

Define the `snuff` method, which takes a lantern and puts it out at once:

```inko
snuff(lantern)
log
# => ['Moon goes out']
```
