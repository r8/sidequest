// A singly linked list used as a stack: values are pushed onto and popped from its head.
// Its representation is up to you: give this type its constructors.
pub type linked-list<a>

// from-list(xs) -> the list made by pushing the elements of `xs` in order, so the last one is on top
pub fun from-list(xs : list<a>) : exn linked-list<a>
  throw("implement me", ExnTodo)

// count(l) -> the number of values in `l`
pub fun count(l : linked-list<a>) : exn int
  throw("implement me", ExnTodo)

// push(l, x) -> `l` with `x` on top
pub fun push(l : linked-list<a>, x : a) : exn linked-list<a>
  throw("implement me", ExnTodo)

// pop(l) -> the value on top of `l` and the list below it; throws "list is empty" if there is none
pub fun pop(l : linked-list<a>) : exn (a, linked-list<a>)
  throw("implement me", ExnTodo)

// peek(l) -> the value on top of `l`; throws "list is empty" if there is none
pub fun peek(l : linked-list<a>) : exn a
  throw("implement me", ExnTodo)

// to-list(l) -> the values of `l` from the top down, the order in which they would be popped
pub fun to-list(l : linked-list<a>) : exn list<a>
  throw("implement me", ExnTodo)

// reverse(l) -> `l` with its values in reverse order, so the bottom value is on top
pub fun reverse(l : linked-list<a>) : exn linked-list<a>
  throw("implement me", ExnTodo)
