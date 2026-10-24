import test
import satellite

fun leaf(x : string) : tree<string>
  Node(Leaf, x, Leaf)

pub fun main()
  run([
    test("Empty tree") { assert-equal(Leaf, tree-from-traversals([] : list<string>, [])) },
    test("Tree with one item") { assert-equal(leaf("a"), tree-from-traversals(["a"], ["a"])) },
    test("Tree with many items") {
      assert-equal(Node(leaf("i"), "a", Node(leaf("f"), "x", leaf("r"))),
                   tree-from-traversals(["a", "i", "x", "f", "r"], ["i", "a", "f", "x", "r"]))
    },
    test("Reject traversals of different length") {
      assert-throws("traversals must have the same length") { tree-from-traversals(["a", "b"], ["b", "a", "r"]) }
    },
    test("Reject inconsistent traversals of same length") {
      assert-throws("traversals must have the same elements") { tree-from-traversals(["x", "y", "z"], ["a", "b", "c"]) }
    },
    test("Reject traversals with repeated items") {
      assert-throws("traversals must contain unique items") { tree-from-traversals(["a", "b", "a"], ["b", "a", "a"]) }
    },
    test("A degenerate binary tree") {
      assert-equal(Node(Node(Node(leaf("d"), "c", Leaf), "b", Leaf), "a", Leaf),
                   tree-from-traversals(["a", "b", "c", "d"], ["d", "c", "b", "a"]))
    },
    test("Another degenerate binary tree") {
      assert-equal(Node(Leaf, "a", Node(Leaf, "b", Node(Leaf, "c", leaf("d")))),
                   tree-from-traversals(["a", "b", "c", "d"], ["a", "b", "c", "d"]))
    },
    test("Tree with many more items") {
      assert-equal(Node(Node(Node(leaf("g"), "d", leaf("h")), "b", Leaf), "a", Node(leaf("e"), "c", Node(leaf("i"), "f", Leaf))),
                   tree-from-traversals(["a", "b", "d", "g", "h", "c", "e", "f", "i"], ["g", "d", "h", "b", "a", "e", "c", "i", "f"]))
    },
  ])
