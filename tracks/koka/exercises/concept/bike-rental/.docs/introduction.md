# Introduction

## Grouping values

Many things a program deals with are several values that belong together: a point has an `x` and a `y`, a book a
title, an author and a year. A tuple could hold them, but `(string, string, int)` says nothing about which string
is the title. A `struct` gives the group a type of its own and each part a name:

```koka
struct book
  title : string
  author : string
  year : int
```

This declares the type `book` with three _fields_. Type names are lower-case in Koka, like every other name.

## Making one

Declaring the struct also defines its _constructor_: a function with the same name, capitalised, that takes the
fields in order.

```koka
val dune = Book("Dune", "Frank Herbert", 1965)
```

Like any function, the constructor accepts named arguments, which reads better when there are several fields of
the same type, and lets you give them in any order:

```koka
val emma = Book(author = "Jane Austen", title = "Emma", year = 1815)
```

## Reading fields

Each field also becomes a function that takes the struct and returns that field, so the usual dot-selection
reads it:

```koka
dune.title         // "Dune"
dune.year + 10     // 1975
```

## Default values

A field can have a default value, written after its type. A constructor call may then leave it out:

```koka
struct boat
  name : string
  seats : int = 2
  hired-by : string = ""

val swan = Boat("Swan")                       // 2 seats, not hired
val duck = Boat("Duck", hired-by = "Ann")     // 2 seats, hired by Ann
```

Fields with defaults usually come last, so that the ones without can be given by position.

## Changing a field — by copying

Structs are values, and like every value in Koka they never change. To get a boat with a different hirer, make a
copy that differs in that field. Calling a struct value with named arguments does exactly that:

```koka
val hired = swan(hired-by = "Omar")
hired.hired-by    // "Omar"
swan.hired-by     // "" — the original is untouched
```

Fields you do not name are copied as they are. You can name several at once, and use the old value to compute
the new one:

```koka
fun add-seat(b : boat) : boat
  b(seats = b.seats + 1)
```

Because the original is never modified, a function like `add-seat` is safe to call on any boat, however many
other parts of the program are holding on to it. (Under the hood Koka reuses the memory when no one else holds the
old value, so copying is cheap.)

## Visibility

`pub struct` makes the type, its constructor and its field functions visible to other modules. Without `pub`
they are private to the module.

## Pitfalls

- Koka does not write `show` or `==` for your structs: `Book(…) == Book(…)` is an error until you define an `==`
  for books yourself. Compare the fields you care about instead, or write those functions by hand; a later lesson
  shows how such functions plug into the rest of the library.
- A field name is also a function name, so it can clash with a function from the standard library. A field called
  `id`, for instance, makes `b.id` ambiguous with std's `id` function. Choose another name, such as `number`.
- For the same reason, a parameter or `val` named like a field hides the field function: inside
  `fun f(b : boat, seats : int)`, `b.seats` means "call the integer `seats` with `b`" and fails to compile. Give
  the parameter a different name.
- Copying names fields, not positions: `swan(3)` is not "set the first field" — always write `swan(seats = 3)`.
