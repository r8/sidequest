# Introduction

Every `.inko` file is a module. A module defines methods with `fn`, giving each argument a type and the result type
after `->`; `pub` makes a method available to other modules:

```inko
fn pub add_tax(price: Int, tax: Int) -> Int {
  price + tax
}
```

The last expression of a method is its return value; `return` is for leaving early. Arguments are passed by
position or by name (`add_tax(100, tax: 20)`), and a method without arguments is called without parentheses.

`let` defines a variable that can't be reassigned, `let mut` one that can. A name starting with a capital letter,
defined at the top level, is a constant:

```inko
let SHELVES = 4

fn pub capacity(per_shelf: Int) -> Int {
  let mut total = SHELVES * per_shelf

  total += 1
  total
}
```

Binary operators have no precedence: `2 + 3 * 4` is `(2 + 3) * 4`, which is 20. Use parentheses whenever you mix
operators. Comments start with `#`.
