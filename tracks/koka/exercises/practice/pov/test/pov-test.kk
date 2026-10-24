import test
import pov

fun leaf(label : string) : tree
  Tree(label, [])

pub fun main()
  run([
    test("Reroot a tree so that its root is the specified node. > Results in the same tree if the input tree is a singleton") {
      assert-equal(Just(leaf("x")), leaf("x").from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Can reroot a tree with a parent and one sibling") {
      val t = Tree("parent", [leaf("x"), leaf("sibling")])
      assert-equal(Just(Tree("x", [Tree("parent", [leaf("sibling")])])), t.from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Can reroot a tree with a parent and many siblings") {
      val t = Tree("parent", [leaf("a"), leaf("x"), leaf("b"), leaf("c")])
      assert-equal(Just(Tree("x", [Tree("parent", [leaf("a"), leaf("b"), leaf("c")])])), t.from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Can reroot a tree with new root deeply nested in tree") {
      val t = Tree("level-0", [Tree("level-1", [Tree("level-2", [Tree("level-3", [leaf("x")])])])])
      val expected = Tree("x", [Tree("level-3", [Tree("level-2", [Tree("level-1", [leaf("level-0")])])])])
      assert-equal(Just(expected), t.from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Moves children of the new root to same level as former parent") {
      val t = Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")])])
      assert-equal(Just(Tree("x", [leaf("kid-0"), leaf("kid-1"), leaf("parent")])), t.from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Can reroot a complex tree with cousins") {
      val t = Tree("grandparent", [
        Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")]), leaf("sibling-0"), leaf("sibling-1")]),
        Tree("uncle", [leaf("cousin-0"), leaf("cousin-1")]),
      ])
      val expected = Tree("x", [
        leaf("kid-1"),
        leaf("kid-0"),
        Tree("parent", [
          leaf("sibling-0"),
          leaf("sibling-1"),
          Tree("grandparent", [Tree("uncle", [leaf("cousin-0"), leaf("cousin-1")])]),
        ]),
      ])
      assert-equal(Just(expected), t.from-pov("x"))
    },
    test("Reroot a tree so that its root is the specified node. > Errors if target does not exist in a singleton tree") {
      assert-equal(Nothing, leaf("x").from-pov("nonexistent"))
    },
    test("Reroot a tree so that its root is the specified node. > Errors if target does not exist in a large tree") {
      val t = Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")]), leaf("sibling-0"), leaf("sibling-1")])
      assert-equal(Nothing, t.from-pov("nonexistent"))
    },
    test("Given two nodes, find the path between them > Can find path to parent") {
      val t = Tree("parent", [leaf("x"), leaf("sibling")])
      assert-equal(Just(["x", "parent"]), t.path-to("x", "parent"))
    },
    test("Given two nodes, find the path between them > Can find path to sibling") {
      val t = Tree("parent", [leaf("a"), leaf("x"), leaf("b"), leaf("c")])
      assert-equal(Just(["x", "parent", "b"]), t.path-to("x", "b"))
    },
    test("Given two nodes, find the path between them > Can find path to cousin") {
      val t = Tree("grandparent", [
        Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")]), leaf("sibling-0"), leaf("sibling-1")]),
        Tree("uncle", [leaf("cousin-0"), leaf("cousin-1")]),
      ])
      assert-equal(Just(["x", "parent", "grandparent", "uncle", "cousin-1"]), t.path-to("x", "cousin-1"))
    },
    test("Given two nodes, find the path between them > Can find path not involving root") {
      val t = Tree("grandparent", [Tree("parent", [leaf("x"), leaf("sibling-0"), leaf("sibling-1")])])
      assert-equal(Just(["x", "parent", "sibling-1"]), t.path-to("x", "sibling-1"))
    },
    test("Given two nodes, find the path between them > Can find path from nodes other than x") {
      val t = Tree("parent", [leaf("a"), leaf("x"), leaf("b"), leaf("c")])
      assert-equal(Just(["a", "parent", "c"]), t.path-to("a", "c"))
    },
    test("Given two nodes, find the path between them > Errors if destination does not exist") {
      val t = Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")]), leaf("sibling-0"), leaf("sibling-1")])
      assert-equal(Nothing, t.path-to("x", "nonexistent"))
    },
    test("Given two nodes, find the path between them > Errors if source does not exist") {
      val t = Tree("parent", [Tree("x", [leaf("kid-0"), leaf("kid-1")]), leaf("sibling-0"), leaf("sibling-1")])
      assert-equal(Nothing, t.path-to("nonexistent", "x"))
    },
  ])
