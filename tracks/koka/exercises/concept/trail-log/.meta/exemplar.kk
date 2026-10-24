// total-distance(legs) -> the total length of the legs of a hike
pub fun total-distance(legs : list<int>) : int
  match legs
    Nil -> 0
    Cons(leg, rest) -> leg + total-distance(rest)

// longest-leg(legs) -> the longest of the legs of a hike, or 0
pub fun longest-leg(legs : list<int>) : int
  match legs
    Nil -> 0
    Cons(leg, rest) -> max(leg, longest-leg(rest))

// total-climb(altitudes) -> the sum of the rises between consecutive waymarks
pub fun total-climb(altitudes : list<int>) : int
  match altitudes
    Cons(a, more as Cons(b, _)) -> max(b - a, 0) + total-climb(more)
    _ -> 0

// waymarks(km) -> the kilometre numbers from `km` down to 1
pub fun waymarks(km : int) : div list<int>
  if km <= 0 then [] else Cons(km, waymarks(km - 1))
