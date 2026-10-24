// A double-ended list: values can be added and removed at both its front and its back.
// It keeps the front part in order and the back part reversed, so both ends are at a list's head.
abstract struct linked-list<a>(front : list<a>, back : list<a>)

// from-list(xs) -> the list holding the elements of `xs`, from front to back
pub fun from-list(xs : list<a>) : linked-list<a>
  Linked-list(xs, [])

// count(l) -> the number of values in `l`
pub fun count(l : linked-list<a>) : int
  l.front.length + l.back.length

// push(l, x) -> `l` with `x` added at the back
pub fun push(l : linked-list<a>, x : a) : linked-list<a>
  Linked-list(l.front, Cons(x, l.back))

// pop(l) -> the value at the back of `l` and the rest of the list; throws "list is empty" if there is none
pub fun pop(l : linked-list<a>) : exn (a, linked-list<a>)
  match l.back
    Cons(x, rest) -> (x, Linked-list(l.front, rest))
    Nil -> match l.front.reverse
      Cons(x, rest) -> (x, Linked-list([], rest))
      Nil -> throw("list is empty")

// unshift(l, x) -> `l` with `x` added at the front
pub fun unshift(l : linked-list<a>, x : a) : linked-list<a>
  Linked-list(Cons(x, l.front), l.back)

// shift(l) -> the value at the front of `l` and the rest of the list; throws "list is empty" if there is none
pub fun shift(l : linked-list<a>) : exn (a, linked-list<a>)
  match l.front
    Cons(x, rest) -> (x, Linked-list(rest, l.back))
    Nil -> match l.back.reverse
      Cons(x, rest) -> (x, Linked-list(rest, []))
      Nil -> throw("list is empty")

fun remove-first(xs : list<a>, x : a, ?(==) : (a, a) -> bool) : list<a>
  match xs
    Nil -> Nil
    Cons(y, rest) -> if y == x then rest else Cons(y, rest.remove-first(x))

// delete(l, x) -> `l` without the first occurrence of `x`, counting from the front; `l` if there is none
pub fun delete(l : linked-list<a>, x : a, ?(==) : (a, a) -> bool) : linked-list<a>
  from-list((l.front ++ l.back.reverse).remove-first(x))
