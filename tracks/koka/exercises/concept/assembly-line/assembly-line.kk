// process-all(items, station) -> `station` applied to each of `items`, in order
pub fun process-all(items : list<a>, station : (a) -> <exn|e> b) : <exn|e> list<b>
  throw("implement me", ExnTodo)

// pipeline(item, stations) -> `item` passed through each of `stations` in turn
pub fun pipeline(item : a, stations : list<(a) -> <exn|e> a>) : <exn|e> a
  throw("implement me", ExnTodo)

// count-passing(items, check) -> how many of `items` the `check` accepts
pub fun count-passing(items : list<a>, check : (a) -> <exn|e> bool) : <exn|e> int
  throw("implement me", ExnTodo)

// inspect-wheel(width) -> `width` if it is between 10 and 20 inclusive; throws "defective wheel" otherwise
pub fun inspect-wheel(width : int) : exn int
  throw("implement me", ExnTodo)

// first-defect(items, check) -> the first of `items` that `check` rejects, checking none after it
pub fun first-defect(items : list<a>, check : (a) -> <exn|e> bool) : <exn|e> maybe<a>
  throw("implement me", ExnTodo)
