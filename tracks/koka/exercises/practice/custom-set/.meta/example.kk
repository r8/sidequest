// A set of values of type `a`, ordered by `cmp`: its elements in ascending order, without duplicates.
abstract struct set<a>(elements : list<a>)

// Inserts `x` into the ascending list `xs` unless it is already there.
fun insert(xs : list<a>, x : a, ?cmp : (a, a) -> order) : list<a>
  match xs
    Nil -> [x]
    Cons(y, rest) -> match cmp(x, y)
      Lt -> Cons(x, xs)
      Eq -> xs
      Gt -> Cons(y, rest.insert(x))

// from-list(xs) -> the set of the elements of `xs`
pub fun from-list(xs : list<a>, ?cmp : (a, a) -> order) : set<a>
  Set(xs.foldl(Nil, insert))

// to-list(s) -> the elements of `s` in ascending order
pub fun to-list(s : set<a>) : list<a>
  s.elements

// is-empty(s) -> whether `s` has no elements
pub fun is-empty(s : set<a>) : bool
  s.elements.is-nil

// contains(s, x) -> whether `x` is an element of `s`
pub fun contains(s : set<a>, x : a, ?cmp : (a, a) -> order) : bool
  s.elements.any(fn(y) y == x)

// is-subset(s1, s2) -> whether every element of `s1` is in `s2`
pub fun is-subset(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : bool
  s1.elements.all(fn(x) s2.contains(x))

// is-disjoint(s1, s2) -> whether `s1` and `s2` share no element
pub fun is-disjoint(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : bool
  s1.elements.all(fn(x) !s2.contains(x))

// is-equal(s1, s2) -> whether `s1` and `s2` have the same elements
pub fun is-equal(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : bool
  s1.is-subset(s2) && s2.is-subset(s1)

// add(s, x) -> `s` with `x` added
pub fun add(s : set<a>, x : a, ?cmp : (a, a) -> order) : set<a>
  Set(s.elements.insert(x))

// intersection(s1, s2) -> the set of the elements in both `s1` and `s2`
pub fun intersection(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : set<a>
  Set(s1.elements.filter(fn(x) s2.contains(x)))

// difference(s1, s2) -> the set of the elements of `s1` that are not in `s2`
pub fun difference(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : set<a>
  Set(s1.elements.filter(fn(x) !s2.contains(x)))

// union(s1, s2) -> the set of the elements in `s1`, `s2` or both
pub fun union(s1 : set<a>, s2 : set<a>, ?cmp : (a, a) -> order) : set<a>
  Set(s2.elements.foldl(s1.elements, insert))
