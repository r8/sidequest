# Instructions

The harbour warehouse ships everything: tea, rice, spare parts, numbered barrels. Foreman Lucía wants one kind of
`Crate` for all of it, rather than a different crate for every cargo. A crate holds up to a fixed number of items,
all of the same type, and the stub declares it as the generic type `Crate[T]`. Add its fields and write its methods.

## 1. Set up a crate

Define the static `new` method, which takes the crate's capacity and returns an empty crate, and the `size` and
`full?` methods:

```inko
let crate: Crate[String] = Crate.new(2)

crate.size
# => 0
crate.full?
# => false
```

## 2. Load the crate

Define the `load` method, which puts an item in the crate. When the crate is full, the item is handed back as an
error, so it isn't lost:

```inko
crate.load('tea')
# => Result.Ok(nil)
crate.load('rice')
# => Result.Ok(nil)
crate.load('salt')
# => Result.Error('salt')
```

## 3. Unload the crate

Items are taken out from the top: the last item loaded comes out first. Define the `unload` method, which returns
the item, or `None` for an empty crate:

```inko
crate.unload
# => Option.Some('rice')
```

## 4. Look for an item

For cargo that can be compared, define the `contains?` method, which returns whether the crate holds an item:

```inko
crate.contains?('tea')
# => true
```

## 5. Write the manifest

For cargo that can be written down as text, define the `manifest` method, which returns the items in the order
they were loaded, separated by `', '`:

```inko
crate.manifest
# => 'tea'
```

## 6. Count cargo

Define the generic `count_matching` method, which takes a list of items of any comparable type and an item to look
for, and returns how many items in the list are equal to it:

```inko
count_matching(['tea', 'rice', 'tea'], 'tea')
# => 2
```
