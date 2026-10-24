# Hints

## General

- The manual's [traits][traits] page covers required and default methods.
- The methods of an `impl` can read the type's fields with `@`.

## 1. Describe a painting

- Interpolate the name and the artist into one string.

## 2. Describe an instrument

- The same as for paintings, with different fields.

## 3. Print a plaque

- A default method can call the trait's required methods, `title` and `year`.

## 4. Invite visitors to play

- The overriding method can call `title` and `year` too, and use the `@playable` field.

## 5. Find the oldest exhibit

- `first` returns an option; `let Some(…) = … else return …` handles the empty list.
- Keep the oldest exhibit seen so far in a `let mut` variable and compare years.

## 6. Make paintings printable

- `to_string` can return the same text as `title`.

[traits]: https://docs.inko-lang.org/manual/latest/getting-started/traits/
