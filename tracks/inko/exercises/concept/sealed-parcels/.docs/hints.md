# Hints

## General

- The manual's [concurrency and recovery][recovery] page explains unique values, `recover`, and what can be done
  with a `uni T`.

## 1. Seal an empty parcel

- The return type is `uni Parcel`, so the parcel created at the end of the method is recovered automatically.

## 2. Add to a sealed parcel

- Write `add` like any other method. Calling it on a `uni Parcel` is allowed because its argument is a `String`.

## 3. Pack a list of items

- The list is borrowed from outside, so it can't go into the sealed parcel as it is; a `clone` of it can, inside a
  `recover`.

## 4. Open a parcel

- `recover` turns a `uni T` back into a `T`.

## 5. Combine parcels

- Do the work inside one `recover { … }` block: recover both parcels into ordinary ones, move the items of the second
  into the first, and end the block with the first parcel.

[recovery]: https://docs.inko-lang.org/manual/latest/getting-started/concurrency/
