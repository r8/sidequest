# Introduction

So far, every value you've used had a type from the standard library: `Int`, `String`, `Array`. With `type` you
define your own, with _fields_ that hold its data and _methods_ that work on it:

```inko
type pub Kettle {
  let @litres: Float
  let mut @temperature: Int
}
```

`pub` makes the type usable from other modules. Each field is declared with `let`, a name starting with `@`, and a
type. The `@` is how fields are told apart from variables and methods, both here and wherever they're used.

## Creating instances

An instance is created by writing the type's name with a value for every field, by name:

```inko
let kettle = Kettle(litres: 1.5, temperature: 20)
```

Values can also be given by position (`Kettle(1.5, 20)`), in the order the fields are defined, but names are
clearer and keep working when fields are reordered.

Usually a type offers a _static method_ that creates instances, so callers don't need to know the fields. Static
methods are defined with `fn static` inside the type and called on the type itself; by convention the main one is
called `new`:

```inko
type pub Kettle {
  let @litres: Float
  let mut @temperature: Int

  fn pub static new(litres: Float) -> Kettle {
    Kettle(litres: litres, temperature: 20)
  }
}

let kettle = Kettle.new(1.5)
```

## Instance methods

Methods defined in a type without `static` are _instance methods_: they are called on an instance, and can read its
fields:

```inko
type pub Kettle {
  …

  fn pub hot? -> Bool {
    @temperature >= 90
  }
}

kettle.hot? # => false
```

Inside an instance method, `self` is the instance the method was called on. You rarely need to write it: other
methods of the same type can be called directly, so `hot?` inside a `Kettle` method means `self.hot?`.

## Changing an instance

Instance methods can't change their instance by default. A method that changes fields must be declared with
`fn mut`, and a field that can be assigned must be declared with `let mut`:

```inko
type pub Kettle {
  let @litres: Float
  let mut @temperature: Int

  fn pub mut boil {
    @temperature = 100
  }

  fn pub mut cool_down(degrees: Int) {
    @temperature -= degrees
  }
}
```

Fields holding a collection don't need `let mut` to have their contents changed: `@readings.push(value)` changes
the array, not which array the field holds, so it only needs an `fn mut` method. `let mut` is for assigning a whole
new value to the field.

Calling an `fn mut` method on an instance stored in a plain `let` variable is fine:

```inko
let kettle = Kettle.new(1.5)

kettle.boil
kettle.hot? # => true
```

## Field types inside methods

In an `fn` method, fields are read-only: a field holding an `Array[Float]` is seen as `ref Array[Float]`, a
read-only borrow, so you can call `size` or `iter` on it but not `push`. In an `fn mut` method, it is seen as
`mut Array[Float]` and can be changed. Numbers, booleans and strings are always just copied.

## Public fields

Fields are private unless declared `let pub @name: String`: only code in the type's own module (and its sibling
modules, as the modules lesson explains) can use them. A public field can be read from
outside as `kettle.litres`, which looks exactly like calling a method without arguments. Keeping fields private and
offering methods lets you change how the data is stored later.

## Formatting long method chains

Methods can be split over several lines by starting each line with the `.`:

```inko
@readings
  .iter
  .map(fn (r) { r * 2.0 })
  .to_array
```
