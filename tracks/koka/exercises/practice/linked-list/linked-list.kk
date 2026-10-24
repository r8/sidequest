// A double-ended list: values can be added and removed at both its front and its back.
// Its representation is up to you: give this type its constructor(s).
pub type linked-list<a>

// from-list(xs) -> the list holding the elements of `xs`, from front to back
pub fun from-list(xs : list<a>) : exn linked-list<a>
  throw("implement me", ExnTodo)

// count(l) -> the number of values in `l`
pub fun count(l : linked-list<a>) : exn int
  throw("implement me", ExnTodo)

// push(l, x) -> `l` with `x` added at the back
pub fun push(l : linked-list<a>, x : a) : exn linked-list<a>
  throw("implement me", ExnTodo)

// pop(l) -> the value at the back of `l` and the rest of the list; throws "list is empty" if there is none
pub fun pop(l : linked-list<a>) : exn (a, linked-list<a>)
  throw("implement me", ExnTodo)

// unshift(l, x) -> `l` with `x` added at the front
pub fun unshift(l : linked-list<a>, x : a) : exn linked-list<a>
  throw("implement me", ExnTodo)

// shift(l) -> the value at the front of `l` and the rest of the list; throws "list is empty" if there is none
pub fun shift(l : linked-list<a>) : exn (a, linked-list<a>)
  throw("implement me", ExnTodo)

// delete(l, x) -> `l` without the first occurrence of `x`, counting from the front; `l` if there is none
pub fun delete(l : linked-list<a>, x : a, ?(==) : (a, a) -> bool) : exn linked-list<a>
  throw("implement me", ExnTodo)
