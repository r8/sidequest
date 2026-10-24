# Instructions

The town museum is small but varied: paintings in the east wing, old musical instruments in the west wing, and
much more in storage. Curator Abebe wants every exhibit to have a plaque, and a listing of what's on display. The
stub defines an `Exhibit` trait and two kinds of exhibits, `Painting` and `Instrument`; fill in the methods.

## 1. Describe a painting

Implement the `title` and `year` methods of `Exhibit` for `Painting`. A painting's title is its name, `by`, and the
artist:

```inko
let lilies = Painting.new(name: 'Water Lilies', artist: 'Claude Monet', year: 1906)

lilies.title
# => 'Water Lilies by Claude Monet'
lilies.year
# => 1906
```

## 2. Describe an instrument

Implement `title` and `year` for `Instrument`. An instrument's title is its kind, `made by`, and its maker:

```inko
Instrument.new(kind: 'Lute', maker: 'Anna Weiss', year: 1612, playable: false).title
# => 'Lute made by Anna Weiss'
```

## 3. Print a plaque

Write the default `plaque` method of the `Exhibit` trait, which returns the title followed by the year in
parentheses:

```inko
lilies.plaque
# => 'Water Lilies by Claude Monet (1906)'
```

## 4. Invite visitors to play

Some instruments may be played by visitors. Instruments override the `plaque` method: their plaque is the same as
any other exhibit's, followed by `, ask to play it` when the instrument is playable:

```inko
Instrument.new(kind: 'Harp', maker: 'Jan Brouwer', year: 1780, playable: true).plaque
# => 'Harp made by Jan Brouwer (1780), ask to play it'
```

## 5. Find the oldest exhibit

Define the `oldest` method, which takes a list of exhibits of any kind and returns the title of the oldest one, or
`'nothing on display'` for an empty list. When two exhibits are equally old, return the first:

```inko
oldest([lilies as Exhibit, lute as Exhibit])
# => 'Lute made by Anna Weiss'
```

## 6. Make paintings printable

`Painting` implements the standard `ToString` trait, so that a painting can be interpolated into a string.
Implement its `to_string` method, which returns the painting's title:

```inko
'Now showing: ${lilies}'
# => 'Now showing: Water Lilies by Claude Monet'
```
