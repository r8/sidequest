// A lock-picking program asks the machine for a digit with `pick-digit`, choosing among `options`, and
// gives up on the current attempt with `dead-end`. The handlers below decide which digits get tried.
pub effect pick
  ctl pick-digit(options : list<int>) : int
  ctl dead-end() : a

// all-outcomes(action) -> the results of `action` for every digit it could pick, in the order of the options
pub fun all-outcomes(action : () -> <pick|e> a) : e list<a>
  with handler
    return(x) [x]
    ctl pick-digit(options) options.map(fn(d) resume(d)).concat
    ctl dead-end() []
  action()

// count-outcomes(action) -> how many ways of picking digits let `action` finish
pub fun count-outcomes(action : () -> <pick|e> a) : e int
  with handler
    return(_) 1
    ctl pick-digit(options) options.foldl(0, fn(total, d) total + resume(d))
    ctl dead-end() 0
  action()

// first-outcome(action) -> the first result of `action` in the order of the options, or Nothing if every attempt is a dead end
pub fun first-outcome(action : () -> <pick|e> a) : e maybe<a>
  with handler
    return(x) Just(x)
    ctl pick-digit(options)
      fun try-each(digits)
        match digits
          Nil -> Nothing
          Cons(d, rest) ->
            match resume(d)
              Just(x) -> Just(x)
              Nothing -> try-each(rest)
      try-each(options)
    ctl dead-end() Nothing
  action()

// combination(length, digits) -> a combination of `length` digits, each picked from `digits`
pub fun combination(length : int, digits : list<int>) : <pick,div> list<int>
  if length <= 0 then []
  else
    val d = pick-digit(digits)
    Cons(d, combination(length - 1, digits))

// opening(length, digits, fits) -> a combination of `length` digits from `digits` for which `fits` holds
pub fun opening(length : int, digits : list<int>, fits : (list<int>) -> bool) : <pick,div> list<int>
  val c = combination(length, digits)
  if fits(c) then c else dead-end()
