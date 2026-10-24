# About

## Declaring

```koka
pub struct book
  title : string
  author : string
  year : int = 2000
```

A struct is a type with a single constructor and named fields. The declaration defines:

- the type `book`;
- the constructor `Book`, a function from the fields to a `book`, which takes named arguments and uses the
  defaults for fields left out;
- a function per field (`title`, `author`, `year`) that reads it, used as `b.title`;
- copying with changes, `b(year = 1999)`.

`pub` exports all of them. A struct may also be written on one line with parentheses,
`struct point(x : int, y : int)`, which is handy for small ones.

## Values, not objects

A struct value is immutable. `b(year = 1999)` returns a new `book` and leaves `b` alone, so any number of places
can share one value without worrying that someone changes it. Koka's reference counting notices when the old
value is no longer used anywhere and then updates it in place, so the copy usually costs nothing (the lesson on
FBIP goes into how).

Copying takes field names only; every field not named is carried over. A copy can compute new fields from the
old ones: `b(year = b.year + 1)`.

## Matching

A struct can also be taken apart with `match`, by position or by field name:

```koka
match b
  Book(title, author) -> title ++ " by " ++ author
```

```koka
match b
  Book(year = y) -> y
```

Since there is only one constructor, such a match never fails.

## What you write yourself

Koka derives nothing for a struct: there is no automatic `show`, `==` or ordering. Define them where you need
them —

```koka
pub fun show(b : book) : string
  b.title ++ " (" ++ b.year.show ++ ")"

pub fun (==)(a : book, b : book) : bool
  a.title == b.title && a.author == b.author && a.year == b.year
```

— and a later lesson on implicit parameters shows how library functions such as the test harness's
`assert-equal` find them.

## Pitfalls

- Field names are function names. Koka picks between same-named functions by their argument types, but std's `id`
  accepts anything, so a field called `id` makes `b.id` ambiguous; pick a more specific name.
- A parameter or local `val` with a field's name hides the field function in its scope: with a parameter
  `seats : int`, `b.seats` fails to compile ("only functions or types with a copy constructor can be applied").
- When a struct has several fields of the same type, named constructor arguments prevent swapping them by
  accident.
