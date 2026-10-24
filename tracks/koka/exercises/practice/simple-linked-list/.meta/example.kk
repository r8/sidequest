// A singly linked list used as a stack: values are pushed onto and popped from its head.
pub type linked-list<a>
  Empty
  Node(value : a, next : linked-list<a>)

// from-list(xs) -> the list made by pushing the elements of `xs` in order, so the last one is on top
pub fun from-list(xs : list<a>) : linked-list<a>
  xs.foldl(Empty, push)

// count(l) -> the number of values in `l`
pub fun count(l : linked-list<a>) : int
  match l
    Empty -> 0
    Node(_, next) -> 1 + next.count

// push(l, x) -> `l` with `x` on top
pub fun push(l : linked-list<a>, x : a) : linked-list<a>
  Node(x, l)

// pop(l) -> the value on top of `l` and the list below it; throws "list is empty" if there is none
pub fun pop(l : linked-list<a>) : exn (a, linked-list<a>)
  match l
    Empty -> throw("list is empty")
    Node(x, next) -> (x, next)

// peek(l) -> the value on top of `l`; throws "list is empty" if there is none
pub fun peek(l : linked-list<a>) : exn a
  l.pop.fst

// to-list(l) -> the values of `l` from the top down, the order in which they would be popped
pub fun to-list(l : linked-list<a>) : list<a>
  match l
    Empty -> Nil
    Node(x, next) -> Cons(x, next.to-list)

// reverse(l) -> `l` with its values in reverse order, so the bottom value is on top
pub fun reverse(l : linked-list<a>) : linked-list<a>
  fun go(rest : linked-list<a>, acc : linked-list<a>) : linked-list<a>
    match rest
      Empty -> acc
      Node(x, next) -> go(next, Node(x, acc))
  go(l, Empty)
