# About

## Making namespaces

Any block whose body contains an export `⇐` evaluates to a namespace instead of its last value. Its fields are
the exported names, and they keep their values from when the block finished. The block can still compute with
private names defined by `←`, which are not fields, and its exported definitions can refer to each other:

```bqn
rect ← {w ⇐ 4 ⋄ h ⇐ 3 ⋄ area ⇐ w × h}
```

`name ⇐` on its own, with no value, exports a name that is defined elsewhere in the block, which is useful at
the top of a file to list its interface in one place: `Area‿Perimeter ⇐`.

A function block with exports is a constructor: each call creates a new, separate namespace. A file is a block
too: `•Import "f.bqn"` runs the file once and returns its namespace; importing it again gives the same
namespace back.

## Reading fields

`ns.field` reads a field. The left side can be a name, `𝕩` or `𝕨`, or a parenthesised expression; fields chain,
`a.b.c`. The field's spelling sets its role, as for any name: `ns.F` is a function, `ns.f` the same field as a
subject. An unknown field is an error.

Destructuring takes several fields at once: `⟨a, b⟩ ← ns` defines `a` and `b`; `⟨x ⇐ a⟩ ← ns` renames;
fields not mentioned are ignored. The same patterns work in a block header, `{𝕊 ⟨a, b⟩: …}`, where a header
pattern that does not match makes the block try its next body.

## Identity and immutability

Fields cannot be assigned from outside the namespace. A namespace created by a block can still hold a value that
changes, if the block defines a variable and exports a function that modifies it with `↩` — this is how BQN
writes mutable objects (see the object-oriented programming page). For plain records, treat namespaces as values
and return new ones.

`≡` and `=` compare namespaces by identity: `{a⇐1} ≡ {a⇐1}` is `0`, while a namespace matches itself. To compare
two records by contents, compare their fields, or represent the record as a list instead.

## Namespaces and lists

A list such as `name‿number` is often enough for a small record and has the advantage of comparing by value and
working with every array primitive. Namespaces earn their place when fields are many, when they have names worth
keeping, or when a record carries functions with it.
