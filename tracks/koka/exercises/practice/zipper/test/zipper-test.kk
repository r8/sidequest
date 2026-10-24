import test
import zipper

fun leaf(x : int) : tree<int>
  Tree(x, Nothing, Nothing)

// The tree every case starts from.
fun initial() : tree<int>
  Tree(1, Just(Tree(2, Nothing, Just(leaf(3)))), Just(leaf(4)))

// Chains moves that may fail: `and-then(m, f)` is Nothing if `m` is, f's result otherwise.
fun and-then(m : maybe<a>, f : (a) -> e maybe<b>) : e maybe<b>
  match m
    Nothing -> Nothing
    Just(x) -> f(x)

pub fun main()
  run([
    test("data is retained") { assert-equal(initial(), initial().from-tree.to-tree) },
    test("left, right and value") {
      assert-equal(Just(3), initial().from-tree.left.and-then(right).map(value))
    },
    test("dead end") { assert-equal(Nothing, initial().from-tree.left.and-then(left)) },
    test("tree from deep focus") {
      assert-equal(Just(initial()), initial().from-tree.left.and-then(right).map(to-tree))
    },
    test("traversing up from top") { assert-equal(Nothing, initial().from-tree.up) },
    test("left, right, and up") {
      assert-equal(Just(3), initial().from-tree.left.and-then(up).and-then(right).and-then(up).and-then(left).and-then(right).map(value))
    },
    test("test ability to descend multiple levels and return") {
      assert-equal(Just(1), initial().from-tree.left.and-then(right).and-then(up).and-then(up).map(value))
    },
    test("set_value") {
      assert-equal(Just(Tree(1, Just(Tree(5, Nothing, Just(leaf(3)))), Just(leaf(4)))),
                   initial().from-tree.left.map(fn(z) z.set-value(5)).map(to-tree))
    },
    test("set_value after traversing up") {
      assert-equal(Just(Tree(1, Just(Tree(5, Nothing, Just(leaf(3)))), Just(leaf(4)))),
                   initial().from-tree.left.and-then(right).and-then(up).map(fn(z) z.set-value(5)).map(to-tree))
    },
    test("set_left with leaf") {
      assert-equal(Just(Tree(1, Just(Tree(2, Just(leaf(5)), Just(leaf(3)))), Just(leaf(4)))),
                   initial().from-tree.left.map(fn(z) z.set-left(Just(leaf(5)))).map(to-tree))
    },
    test("set_right with null") {
      assert-equal(Just(Tree(1, Just(leaf(2)), Just(leaf(4)))),
                   initial().from-tree.left.map(fn(z) z.set-right(Nothing)).map(to-tree))
    },
    test("set_right with subtree") {
      assert-equal(Tree(1, Just(Tree(2, Nothing, Just(leaf(3)))), Just(Tree(6, Just(leaf(7)), Just(leaf(8))))),
                   initial().from-tree.set-right(Just(Tree(6, Just(leaf(7)), Just(leaf(8))))).to-tree)
    },
    test("set_value on deep focus") {
      assert-equal(Just(Tree(1, Just(Tree(2, Nothing, Just(leaf(5)))), Just(leaf(4)))),
                   initial().from-tree.left.and-then(right).map(fn(z) z.set-value(5)).map(to-tree))
    },
    test("different paths to same zipper") {
      assert-equal(initial().from-tree.right, initial().from-tree.left.and-then(up).and-then(right))
    },
  ])
