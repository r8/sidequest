# Introduction

A block that defines names with `⇐` returns a _namespace_: a value whose fields are those exported names.
Names defined with `←` in the same block stay private. Fields are read with a dot.

```bqn
Point ← {𝕊 x‿y: px ⇐ x ⋄ py ⇐ y}
p ← Point 3‿4
p.px              # 3
⟨px, py⟩ ← p      # destructure by field name
```

A field holding a function is spelled with a capital and called through the dot: `tools.Double 4`.
Namespaces never change; to update one, build a new namespace from the old one's fields. They are compared by
identity, so two namespaces with the same fields do not match. `•Import` returns the namespace of a file's
exports.
