# Introduction

A trait is a named set of methods that types implement; Inko shares behaviour through traits rather than
inheritance.

```inko
trait pub Animal {
  fn pub name -> String                    # required
  fn pub describe -> String { 'I am ${name}' } # default
}

impl Animal for Dog {
  fn pub name -> String { @name }
}
```

Implementations may override default methods. A trait can be used as a type (`Array[Animal]`); values are converted
explicitly with `value as Animal`, and method calls on them run the implementation of the value's actual type.
Standard traits such as `ToString`, `Equal` and `Format` hook types into interpolation, `==` and test output.
