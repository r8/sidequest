import test
import binary-search-tree

fun leaf(x : int) : tree<int>
  Node(Leaf, x, Leaf)

pub fun main()
  run([
    test("data is retained") { assert-equal(leaf(4), from-list([4])) },
    test("insert data at proper node > smaller number at left node") {
      assert-equal(Node(leaf(2), 4, Leaf), from-list([4, 2]))
    },
    test("insert data at proper node > same number at left node") {
      assert-equal(Node(leaf(4), 4, Leaf), from-list([4, 4]))
    },
    test("insert data at proper node > greater number at right node") {
      assert-equal(Node(Leaf, 4, leaf(5)), from-list([4, 5]))
    },
    test("can create complex tree") {
      assert-equal(Node(Node(leaf(1), 2, leaf(3)), 4, Node(leaf(5), 6, leaf(7))), from-list([4, 2, 6, 1, 3, 5, 7]))
    },
    test("can sort data > can sort single number") { assert-equal([2], from-list([2]).sorted-data) },
    test("can sort data > can sort if second number is smaller than first") {
      assert-equal([1, 2], from-list([2, 1]).sorted-data)
    },
    test("can sort data > can sort if second number is same as first") {
      assert-equal([2, 2], from-list([2, 2]).sorted-data)
    },
    test("can sort data > can sort if second number is greater than first") {
      assert-equal([2, 3], from-list([2, 3]).sorted-data)
    },
    test("can sort data > can sort complex tree") {
      assert-equal([1, 2, 3, 5, 6, 7], from-list([2, 1, 3, 6, 7, 5]).sorted-data)
    },
  ])
