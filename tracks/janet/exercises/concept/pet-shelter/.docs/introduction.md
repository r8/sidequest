# Introduction

Janet has no classes, but its tables can share behaviour through _prototypes_: when a table does not have a key, the lookup continues in another table, its prototype.
Together with _method calls_ — calling a keyword on a table — that gives a small, flexible object system.

## Prototypes

`(table/setproto t proto)` makes `proto` the prototype of the table `t` and returns `t`.
Looking up a key that `t` does not have then looks in `proto`, and in `proto`'s prototype after that, all the way up the chain:

```janet
(def Vehicle @{:wheels 4 :fuel "petrol"})
(def bike (table/setproto @{:wheels 2 :owner "Sam"} Vehicle))

(bike :owner)   # => "Sam", the bike's own key
(bike :wheels)  # => 2, the bike's own value shadows the prototype's
(bike :fuel)    # => "petrol", found in the prototype
```

`get`, `in` and calling the table as a function all follow the chain.
`(table/getproto t)` returns a table's prototype (or `nil`), and `(table/rawget t k)` looks only in the table itself:

```janet
(table/rawget bike :fuel)        # => nil
(= Vehicle (table/getproto bike)) # => true
```

Functions that list a table's contents, such as `keys`, `values` and `pairs`, and the loops `eachk` and `eachp`, only see its _own_ keys:

```janet
(keys bike) # => @[:wheels :owner], in some order
```

## Writing goes to the table itself

`put` always changes the table you give it, never its prototype.
Putting a key that came from the prototype gives the table its own value, which from then on shadows the prototype's:

```janet
(def car (table/setproto @{} Vehicle))
(put car :fuel "electric")
(car :fuel)     # => "electric"
(Vehicle :fuel) # => "petrol", unchanged
```

Changing the prototype, on the other hand, changes what every table that inherits from it sees for keys they do not have themselves.
That is often the point: behaviour lives in one place.

## Methods

A method is a function stored in a table, whose first parameter, by convention called `self`, is the table it was called on.
Calling a keyword as if it were a function, `(:key t args…)`, looks up `:key` in `t` — following the prototype chain — and calls what it finds with `t` itself as the first argument:

```janet
(def Vehicle
  @{:wheels 4
    :describe (fn [self] (string "a vehicle with " (self :wheels) " wheels"))
    :honk (fn [self times] (string/repeat "beep " times))})

(def bike (table/setproto @{:wheels 2} Vehicle))

(:describe bike)  # => "a vehicle with 2 wheels"
(:honk bike 2)    # => "beep beep "
```

`(:describe bike)` means `((get bike :describe) bike)`.
Because the method receives `bike`, its `(self :wheels)` finds the bike's own `2`, not the prototype's `4`.
Calling a method that no table in the chain has is an error: `unknown method :fly invoked on …`.

A method can change its object with `put`, and returning `self` lets calls be chained:

```janet
(def Counter @{:add (fn [self n] (put self :count (+ (self :count) n)) self)})
(def c (table/setproto @{:count 0} Counter))
(:add (:add c 2) 3)
(c :count) # => 5
```

## Inheritance

A prototype is just a table, so it can have a prototype of its own.
A more specific prototype overrides some methods and inherits the rest:

```janet
(def Truck (table/setproto @{:wheels 6} Vehicle))
(def lorry (table/setproto @{:owner "Kim"} Truck))

(:describe lorry) # => "a vehicle with 6 wheels"; the method from Vehicle, the wheels from Truck
```

Conventionally, prototypes are named with a capital letter (`Vehicle`, `Truck`), and a small constructor function creates the instances:

```janet
(defn new-truck [owner]
  (table/setproto @{:owner owner} Truck))
```

## Pitfalls

- `(t :key)` on a table and `(:key t)` look alike but are different: the first looks the key up, the second calls the method stored under it.
- Methods are ordinary functions: forgetting the `self` parameter shifts every argument by one.
- Structs can have prototypes too (`struct/with-proto`), but since they cannot change, most object-like code uses tables.
