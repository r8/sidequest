// process-all(items, station) -> `station` applied to each of `items`, in order
pub fun process-all(items : list<a>, station : (a) -> e b) : e list<b>
  items.map(station)

// pipeline(item, stations) -> `item` passed through each of `stations` in turn
pub fun pipeline(item : a, stations : list<(a) -> e a>) : e a
  stations.foldl(item) fn(x, station)
    station(x)

// count-passing(items, check) -> how many of `items` the `check` accepts
pub fun count-passing(items : list<a>, check : (a) -> e bool) : e int
  items.filter(check).length

// inspect-wheel(width) -> `width` if it is between 10 and 20 inclusive; throws "defective wheel" otherwise
pub fun inspect-wheel(width : int) : exn int
  if width >= 10 && width <= 20 then width else throw("defective wheel")

// first-defect(items, check) -> the first of `items` that `check` rejects, checking none after it
pub fun first-defect(items : list<a>, check : (a) -> e bool) : e maybe<a>
  items.find fn(x)
    !check(x)
