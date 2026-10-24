# Instructions

The sorting centre of a small courier company runs through the night.
Everything that comes in on the conveyor has been scanned into a little piece of data: letters and parcels are tuples tagged with a keyword, addresses are structs, and the stickers on the boxes are tagged tuples too.
The old sorting script is a tangle of `if`s; the night shift lead, Tomasz, asks you to rewrite it with `match`.

## 1. Work out the postage

Define the function `postage` that takes an item and returns its postage in stamps:

- a postcard, `[:postcard]`, costs 1;
- a letter, `[:letter grams]`, costs 1 up to and including 20 grams, 2 up to and including 100 grams, and 4 above that;
- a parcel, `[:parcel grams]`, costs 5 plus 1 for every full 1000 grams;
- anything else returns `nil`.

```janet
(postage [:letter 50])
# => 2
(postage [:parcel 2500])
# => 7
```

## 2. Route by address

Define the function `route` that takes an address struct and returns where it goes:

- an address with `:country` `"NL"` and a `:city` goes to `"local: "` followed by the city;
- an address with `:country` `"BE"` or `"DE"` goes to `"neighbour"`;
- an address with any other `:country` goes to `"abroad: "` followed by the country;
- an address without a country goes to `"return to sender"`.

```janet
(route {:country "NL" :city "Utrecht" :street "Oudegracht 1"})
# => "local: Utrecht"
(route {:country "FR" :city "Lyon"})
# => "abroad: FR"
```

## 3. Read the stickers

Define the function `sticker-text` that takes a sticker and returns the text printed on it:

- `[:fragile]` is `"Fragile"`, and `[:fragile "glass" "china"]` lists what is inside: `"Fragile: glass, china"`;
- `[:keep-cold degrees]` is `"Keep frozen"` when the degrees are below zero, otherwise `"Keep below 5 degrees"` for 5 degrees;
- `[:this-side-up]` is `"This side up"`.

```janet
(sticker-text [:fragile "vase"])
# => "Fragile: vase"
(sticker-text [:keep-cold -18])
# => "Keep frozen"
```

## 4. Pick the parcels for a depot

Each parcel is a struct whose `:to` is an address struct.
Define the function `for-depot?` that takes a parcel and the name of a depot's city, and returns `true` when the parcel is addressed to that city and `false` otherwise.

```janet
(for-depot? {:id 7 :to {:city "Delft" :country "NL"}} "Delft")
# => true
(for-depot? {:id 8 :to {:city "Gouda" :country "NL"}} "Delft")
# => false
```
