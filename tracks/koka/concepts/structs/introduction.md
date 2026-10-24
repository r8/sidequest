# Introduction

A `struct` is a type made of named fields:

```koka
struct boat
  name : string
  seats : int = 2
```

Declaring it defines the constructor `Boat`, called with the fields in order or by name (`Boat("Swan")`,
`Boat(seats = 4, name = "Gull")`); fields with a default value may be left out. Each field is also a function,
so `swan.seats` reads it. Structs never change: `swan(seats = 4)` makes a copy with that field replaced and the
others kept. Koka does not derive `show` or `==` for a struct, and a parameter named like a field hides the field
function.
