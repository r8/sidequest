# Instructions

Signal box 7 controls the junction outside Brackwater station, where three lines meet. Dispatcher Orla decides
which platform each train uses, what the departure board says and which signal to show, and she wants the rules
written down as code before she retires.

## 1. Assign a platform

The red and blue lines use platform 1, the green line uses platform 2, and any other train is sent to platform 0
(the siding). Define the `platform` method, which takes the name of a line:

```inko
platform('blue')
# => 1
```

## 2. Show the delay

Define the `board` method, which takes a delay in minutes and returns the text for the departure board:

| Delay | Text |
| --- | --- |
| 0 or less | `'on time'` |
| 1 to 4 | `'slight delay'` |
| 5 to 59 | `'delayed N min'`, such as `'delayed 25 min'` |
| 60 or more | `'cancelled'` |

```inko
board(25)
# => 'delayed 25 min'
```

## 3. Choose the signal

Define the `signal` method, which takes whether the line ahead is clear and whether the next platform is occupied,
and returns `'green'` when the line is clear and the platform free, `'yellow'` when the line is clear but the
platform occupied, and `'red'` when the line isn't clear:

```inko
signal(clear: true, occupied: true)
# => 'yellow'
```

## 4. Announce the next stop

Define the `next_stop` method, which takes the next stop of a train, if there is one, and returns the announcement:

```inko
next_stop(Option.Some('Millbrook'))
# => 'Next stop: Millbrook'
next_stop(Option.None)
# => 'This train terminates here'
```

## 5. Route a train

A train is a pair of its service name and its platform, if it has one yet. Define the `route` method, which returns
`'Express to platform N'` for the `'express'` service, `'NAME to platform N'` for any other service with a
platform, and `'NAME waits'` for a train without one:

```inko
route(('express', Option.Some(1)))
# => 'Express to platform 1'
route(('local', Option.None))
# => 'local waits'
```

## 6. Read a fare zone

Tickets carry a zone code such as `'Z3'`: a `Z` followed by the zone number. Define the `zone` method, which
returns the zone number, or `0` when the code doesn't start with `Z` or isn't followed by a number:

```inko
zone('Z3')
# => 3
zone('Q3')
# => 0
```
