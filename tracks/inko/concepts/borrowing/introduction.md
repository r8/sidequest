# Introduction

A borrow uses a value without owning it. `ref T` is an immutable borrow (read and call `fn` methods), `mut T` a
mutable one (also `fn mut` methods and field assignments). They're created with `ref value` and `mut value`, or
automatically when a value is passed where a borrow is expected.

Collections hand out borrows for values that stay inside them (`get`, `get_mut`, `first`, `iter`, `iter_mut`) and
owned values for those they give up (`pop`, `remove_at`, `into_iter`).

Every value counts its borrows. Dropping an owned value that is still borrowed panics ("can't drop a value … as it
still has 1 reference(s)"), so borrows must not outlive their owners.
