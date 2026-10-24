# Instructions

The parcel depot in Trondheim sends parcels on to other towns, and a parcel that leaves the depot must be sealed:
once sealed, nothing outside the parcel may refer to what's inside it, so nobody can change its contents on the way.
In Inko terms, a sealed parcel is a `uni Parcel`. The stub defines the `Parcel` type; write the methods that seal,
pack and open parcels.

## 1. Seal an empty parcel

Define the static `seal` method, which returns an empty, sealed parcel with a label:

```inko
let parcel = Parcel.seal('Oslo')

parcel.label
# => 'Oslo'
```

## 2. Add to a sealed parcel

Items can be slipped into a sealed parcel, since an item (a `String`) can't be used to refer back into it. Define the
`add` method:

```inko
parcel.add('books')
parcel.items
# => ['books']
```

## 3. Pack a list of items

Define the `pack` method, which takes a label and a list of items and returns a sealed parcel holding a copy of the
list. The list itself stays with the sender:

```inko
pack('Bergen', ['books', 'tea']).items
# => ['books', 'tea']
```

## 4. Open a parcel

Define the `open` method, which takes a sealed parcel and returns it as an ordinary parcel, which can be borrowed
and used like any other value:

```inko
let opened = open(pack('Bergen', ['books']))
```

## 5. Combine parcels

Two sealed parcels for the same town are combined into one. Define the `combine` method, which returns one sealed
parcel with the label of the first, holding the items of the first followed by those of the second:

```inko
combine(pack('Oslo', ['books']), pack('Bergen', ['tea'])).items
# => ['books', 'tea']
```
