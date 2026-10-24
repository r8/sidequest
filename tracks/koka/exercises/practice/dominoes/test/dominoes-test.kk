import test
import dominoes

// Whether `xs` is a reordering of `ys`, each domino possibly flipped.
fun same-stones(xs : list<(int, int)>, ys : list<(int, int)>) : bool
  match xs
    Nil -> ys.is-nil
    Cons((a, b), rest) ->
      val n = ys.index-of(fn(y) y == (a, b) || y == (b, a))
      n >= 0 && same-stones(rest, ys.take(n) ++ ys.drop(n + 1))

// Whether neighbouring dominoes in `xs` match and its two ends match each other.
fun is-chain(xs : list<(int, int)>) : bool
  match xs
    Nil -> True
    Cons((first, _), _) ->
      val ends-match = match xs.last
        Just((_, last)) -> first == last
        Nothing -> False
      ends-match && zip(xs, xs.drop(1)).all(fn(p) p.fst.snd == p.snd.fst)

// Passes when `chain(dominoes)` is a valid chain made of exactly these dominoes.
fun assert-chain(dominoes : list<(int, int)>) : <div,exn> ()
  match chain(dominoes)
    Nothing -> throw("expected a chain, got Nothing", ExnAssert)
    Just(xs) ->
      if !same-stones(xs, dominoes) then
        throw("expected a chain of the given dominoes, got " ++ xs.show, ExnAssert)
      if !is-chain(xs) then
        throw("expected neighbouring dominoes and the two ends to match, got " ++ xs.show, ExnAssert)

pub fun main()
  run([
    test("empty input = empty output") { assert-chain([]) },
    test("singleton input = singleton output") { assert-chain([(1, 1)]) },
    test("singleton that can't be chained") { assert-equal(Nothing, chain([(1, 2)])) },
    test("three elements") { assert-chain([(1, 2), (3, 1), (2, 3)]) },
    test("can reverse dominoes") { assert-chain([(1, 2), (1, 3), (2, 3)]) },
    test("can't be chained") { assert-equal(Nothing, chain([(1, 2), (4, 1), (2, 3)])) },
    test("disconnected - simple") { assert-equal(Nothing, chain([(1, 1), (2, 2)])) },
    test("disconnected - double loop") { assert-equal(Nothing, chain([(1, 2), (2, 1), (3, 4), (4, 3)])) },
    test("disconnected - single isolated") { assert-equal(Nothing, chain([(1, 2), (2, 3), (3, 1), (4, 4)])) },
    test("need backtrack") { assert-chain([(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)]) },
    test("separate loops") { assert-chain([(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)]) },
    test("nine elements") { assert-chain([(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)]) },
    test("separate three-domino loops") { assert-equal(Nothing, chain([(1, 2), (2, 3), (3, 1), (4, 5), (5, 6), (6, 4)])) },
  ])
