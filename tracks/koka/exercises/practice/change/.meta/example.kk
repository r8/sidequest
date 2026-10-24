// Inserts `x` into the ascending list `xs`.
fun insert(x : int, xs : list<int>) : list<int>
  match xs
    Cons(y, ys) | y < x -> Cons(y, insert(x, ys))
    _ -> Cons(x, xs)

fun shorter(a : maybe<list<int>>, b : maybe<list<int>>) : maybe<list<int>>
  match (a, b)
    (Just(xs), Just(ys)) -> if ys.length < xs.length then b else a
    (Nothing, _) -> b
    _ -> a

// The fewest coins for `amount`, given `memo`: the answers for amount - 1, amount - 2, …, 0.
fun fewest(coins : list<int>, memo : list<maybe<list<int>>>, amount : int) : maybe<list<int>>
  coins.filter(fn(c) c > 0 && c <= amount)
       .map(fn(c) memo[c - 1].default(Nothing).map(fn(rest) insert(c, rest)))
       .foldl(Nothing, shorter)

// find-fewest-coins(coins, target) -> the fewest coins from `coins` (any number of each) that
// add up to `target`, in ascending order.
// Throws "target can't be negative" or "can't make target with given coins"
pub fun find-fewest-coins(coins : list<int>, target : int) : exn list<int>
  if target < 0 then throw("target can't be negative")
  val memo = list(1, target).foldl([Just([])], fn(memo, amount) Cons(fewest(coins, memo, amount), memo))
  match memo
    Cons(Just(answer), _) -> answer
    _ -> throw("can't make target with given coins")
