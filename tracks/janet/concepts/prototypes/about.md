# About

## The prototype chain

Every table has at most one prototype, set with `(table/setproto t proto)` (which returns `t`) and read with `(table/getproto t)`.
Lookups — `get`, `in`, `(t key)` and method calls — try the table, then its prototype, then that table's prototype, until a value is found or the chain ends.
A prototype is an ordinary table: it can be changed at any time, and every table that inherits from it sees the change for the keys it does not define itself.

| operation | follows the chain |
| --- | --- |
| `(get t k)`, `(in t k)`, `(t k)`, `has-key?` | yes |
| `(:method t …)` | yes |
| `(table/rawget t k)` | no |
| `keys`, `values`, `pairs`, `length`, `eachk`, `eachp`, `next` | no |
| `put`, `set` on a key | writes to `t` itself |

`(table/proto-flatten t)` returns a new table with every key of the chain merged in, the nearest table winning — useful for printing an object with everything it inherits.

## Method calls

`(:name obj a b)` is shorthand for `((get obj :name) obj a b)`.
If nothing in the chain has the key, the call fails with `unknown method :name invoked on …`.
Methods are plain functions, so the first parameter is just a convention: name it `self`.

Since the method receives the object, values it reads through `self` come from the object first and the prototype second; that is how one method serves every kind that inherits it.

A method may also be called directly with an explicit object: `((Animal :speak) rex)` calls the `Animal` version even when `rex`'s own prototype overrides it — the way to call a "super" method.

## Constructors and conventions

Janet has no `new`; a constructor is a function that builds a fresh table and sets its prototype:

```janet
(defn new-dog [name]
  (table/setproto @{:name name} Dog))
```

Prototypes are usually named with a leading capital, and per-object state lives in the object's own table, never in the shared prototype: a mutable value such as an array stored in the prototype would be shared by every instance.

## Structs with prototypes

`(struct/with-proto proto & kvs)` creates a struct with a prototype, and `struct/getproto` reads it.
Such structs are immutable, so they suit value-like objects whose methods only compute.

## Abstract types and methods

The same `(:method x)` syntax works on many built-in abstract types — `(:close file)`, `(:read file :all)` — because they implement methods in C.
The `with` macro relies on that convention: it calls `:close` on the resource when its body ends.
