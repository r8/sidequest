// A set of values of type `a`, ordered by `cmp`. Its representation is up to you: give this type
// its constructor(s).
pub type set<a>

// from-list(xs) -> the set of the elements of `xs`
pub fun from-list(xs : list<a>, ?cmp : (a, a) -> order) : exn set<a>
  throw("implement me", ExnTodo)

// to-list(s) -> the elements of `s` in ascending order
pub fun to-list(s : set<a>) : exn list<a>
  throw("implement me", ExnTodo)

// is-empty(s) -> whether `s` has no elements
pub fun is-empty(s : set<a>) : exn bool
  throw("implement me", ExnTodo)

// contains(s, x) -> whether `x` is an element of `s`
pub fun contains(s : set<a>, x : a, ?cmp : (a, a) -> order) : exn bool
  throw("implement me", ExnTodo)

// is-subset(s1, s2) -> whether every element of `s1` is in `s2`
pub fun is-subset(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn bool
  throw("implement me", ExnTodo)

// is-disjoint(s1, s2) -> whether `s1` and `s2` share no element
pub fun is-disjoint(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn bool
  throw("implement me", ExnTodo)

// is-equal(s1, s2) -> whether `s1` and `s2` have the same elements
pub fun is-equal(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn bool
  throw("implement me", ExnTodo)

// add(s, x) -> `s` with `x` added
pub fun add(s : set<a>, x : a, ?cmp : (a, a) -> order) : exn set<a>
  throw("implement me", ExnTodo)

// intersection(s1, s2) -> the set of the elements in both `s1` and `s2`
pub fun intersection(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn set<a>
  throw("implement me", ExnTodo)

// difference(s1, s2) -> the set of the elements of `s1` that are not in `s2`
pub fun difference(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn set<a>
  throw("implement me", ExnTodo)

// union(s1, s2) -> the set of the elements in `s1`, `s2` or both
pub fun union(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : exn set<a>
  throw("implement me", ExnTodo)
