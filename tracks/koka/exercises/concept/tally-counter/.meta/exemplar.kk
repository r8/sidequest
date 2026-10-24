// A volunteer spots a bird of the species `bird`.
pub effect fun spot(bird : string) : ()

// The number for a new volunteer's badge.
pub effect fun ticket() : int

// numbered(first, action) -> the result of `action`, where tickets are numbered from `first` up
pub fun numbered(first : int, action : () -> <ticket|e> a) : e a
  var next := first
  with fun ticket()
    val number = next
    next := next + 1
    number
  action()

// count-spots(action) -> the result of `action` and the number of birds it spotted
pub fun count-spots(action : () -> <spot|e> a) : e (a, int)
  var count := 0
  with handler
    return(x) (x, count)
    fun spot(_) count := count + 1
  action()

// spotted(action) -> the result of `action` and the birds it spotted, in order
pub fun spotted(action : () -> <spot|e> a) : e (a, list<string>)
  var log := []
  with handler
    return(x) (x, log.reverse)
    fun spot(bird) log := Cons(bird, log)
  action()

// species(action) -> the number of different species `action` spotted
pub fun species(action : () -> <spot|e> a) : e int
  var seen := []
  with handler
    return(_) seen.length
    fun spot(bird) if !seen.contains(bird) then seen := Cons(bird, seen)
  action()
