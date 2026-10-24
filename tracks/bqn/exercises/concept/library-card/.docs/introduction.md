# Introduction

## Namespaces

A _namespace_ is a value that holds named fields. A block that defines names with `⇐` instead of `←` does not
return its last value: it returns a namespace whose fields are the names it exported.

```bqn
card ← {name ⇐ "Ada" ⋄ books ⇐ 3}
card.name     # "Ada"
card.books    # 3
```

A field is read with a dot: `card.name`, with no space around the dot. On its left can be a name, `𝕩` or
`𝕨`, or an expression in parentheses: `(MakeCard @).name`. Names defined with plain `←` inside the block stay private:
they can be used by the block's other lines but are not fields.

```bqn
box ← {
  width ⇐ 4
  height ⇐ 3
  border ← 1               # private
  area ⇐ (width + border) × height + border
}
box.area      # 20
```

Asking for a field that does not exist, such as `box.border`, is an error.

## Functions that build namespaces

A function block with `⇐` lines returns a fresh namespace each time it is called, which makes it a little
record constructor. A header lets the function take its arguments apart first:

```bqn
Point ← {𝕊 x‿y: px ⇐ x ⋄ py ⇐ y}
p ← Point 3‿4
p.px          # 3
```

Fields may hold any value: numbers, strings, lists, other namespaces, and functions. A field holding a function
is spelled with a capital, like any function name, and called through the dot:

```bqn
shapes ← {Square ⇐ {𝕩 × 𝕩} ⋄ sides ⇐ 4}
shapes.Square 5    # 25
```

The spelling has to match the value: `square ⇐ {𝕩 × 𝕩}` is an error, because a block that uses `𝕩` is a
function and a lowercase name is a subject.

## Reading fields in functions

A function can read the fields of a namespace argument with `𝕩.field` and `𝕨.field`:

```bqn
Distance ← {(𝕩.px × 𝕩.px) + 𝕩.py × 𝕩.py}
Distance p    # 25
```

When a function needs several fields, destructuring takes them out at once. A list of names in `⟨…⟩` on the left
of `←` matches fields by name, in any order:

```bqn
⟨py, px⟩ ← p
px            # 3
```

`⟨new ⇐ old⟩ ← ns` defines `new` from the field `old`, for when the field's name is already taken. A header can
destructure a namespace argument the same way: `{𝕊 ⟨px, py⟩: px + py}`.

## Namespaces do not change

There is no way to assign to a field from outside: `p.px ↩ 5` is an error. To "update" a record, build a new
namespace from the old one's fields; the old one is left as it was.

```bqn
Move ← {px ⇐ 𝕨.px + 1 ⋄ py ⇐ 𝕨.py}
q ← p Move @
q.px          # 4
p.px          # still 3
```

Two namespaces are compared by identity, not by contents: `{a⇐1} ≡ {a⇐1}` is `0`. Compare their fields
instead.

## Files are namespaces

You have been using namespaces since the first exercise. `•Import "file.bqn"` runs a file and returns a
namespace of the names it exports with `⇐`, which is why the tests write `g ← •Import "../library-card.bqn"` and
then call `g.NewCard`.
