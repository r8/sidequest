// The rail that position `i` of the message lands on.
fun rail(i : int, rails : int) : int
  val cycle = 2 * (rails - 1)
  if cycle <= 0 then 0
  else
    val k = i % cycle
    min(k, cycle - k)

// The positions of a message of length `n`, in the order the cipher text reads them.
fun fence-order(n : int, rails : int) : list<int>
  val positions = list(0, n - 1)
  list(0, rails - 1).flatmap(fn(r) positions.filter(fn(i) rail(i, rails) == r))

// encode(msg, rails) -> `msg` written in a zig-zag over `rails` rails, then read off rail by rail
pub fun encode(msg : string, rails : int) : exn string
  val chars = msg.vector
  fence-order(chars.length, rails).map(fn(i) chars[i]).string

// decode(msg, rails) -> the plain text that `encode(plaintext, rails)` turned into `msg`
pub fun decode(msg : string, rails : int) : exn string
  val placed = zip(fence-order(msg.count, rails), msg.list)
  list(0, msg.count - 1).filter-map(fn(i) placed.lookup(fn(p) p == i)).string
