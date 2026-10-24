import test
import simple-linked-list

fun empty-list() : exn linked-list<int>
  from-list([])

pub fun main()
  run([
    test("count > Empty list has length of zero") { assert-equal(0, empty-list().count) },
    test("count > Singleton list has length of one") { assert-equal(1, from-list([1]).count) },
    test("count > Non-empty list has correct length") { assert-equal(3, from-list([1, 2, 3]).count) },
    test("pop > Pop from empty list is an error") { assert-throws("list is empty") { empty-list().pop } },
    test("pop > Can pop from singleton list") { assert-equal(1, from-list([1]).pop.fst) },
    test("pop > Can pop from non-empty list") { assert-equal(2, from-list([1, 2]).pop.fst) },
    test("pop > Can pop multiple items") {
      val (x1, l1) = from-list([1, 2]).pop
      assert-equal(2, x1)
      val (x2, _) = l1.pop
      assert-equal(1, x2)
    },
    test("pop > Pop updates the count") {
      val l = from-list([1, 2])
      assert-equal(2, l.count)
      val (x1, l1) = l.pop
      assert-equal(2, x1)
      assert-equal(1, l1.count)
      val (x2, l2) = l1.pop
      assert-equal(1, x2)
      assert-equal(0, l2.count)
    },
    test("push > Can push to an empty list") { assert-equal([1], empty-list().push(1).to-list) },
    test("push > Can push to a non-empty list") { assert-equal([3, 2, 1], from-list([1, 2]).push(3).to-list) },
    test("push > Push updates count") { assert-equal(3, from-list([1, 2]).push(3).count) },
    test("push > Push and pop") {
      val (x1, l1) = empty-list().push(1).push(2).pop
      assert-equal(2, x1)
      val l2 = l1.push(3)
      assert-equal(2, l2.count)
      val (x2, l3) = l2.pop
      assert-equal(3, x2)
      val (x3, l4) = l3.pop
      assert-equal(1, x3)
      assert-equal(0, l4.count)
    },
    test("peek > Peek on empty list is an error") { assert-throws("list is empty") { empty-list().peek } },
    test("peek > Can peek on singleton list") { assert-equal(1, from-list([1]).peek) },
    test("peek > Can peek on non-empty list") { assert-equal(2, from-list([1, 2]).peek) },
    test("peek > Peek does not change the count") {
      val l = from-list([1, 2])
      assert-equal(2, l.peek)
      assert-equal(2, l.count)
    },
    test("peek > Can peek after a pop and push") {
      val l1 = empty-list().push(1).push(2)
      assert-equal(2, l1.peek)
      val (x, l2) = l1.pop
      assert-equal(2, x)
      assert-equal(1, l2.peek)
      assert-equal(3, l2.push(3).peek)
    },
    test("toList LIFO > Empty linked list to list is empty") { assert-equal([], empty-list().to-list) },
    test("toList LIFO > To list with multiple values") { assert-equal([3, 2, 1], from-list([1, 2, 3]).to-list) },
    test("toList LIFO > To list after a pop") {
      val (x, l) = empty-list().push(1).push(2).push(3).pop
      assert-equal(3, x)
      assert-equal([4, 2, 1], l.push(4).to-list)
    },
    test("reverse > Reversed empty list has same values") { assert-equal([], empty-list().reverse.to-list) },
    test("reverse > Reversed singleton list is same list") { assert-equal([1], from-list([1]).reverse.to-list) },
    test("reverse > Reversed non-empty list is reversed") {
      val l = from-list([1, 2, 3]).reverse
      assert-equal(3, l.count)
      val (x1, l1) = l.pop
      assert-equal(1, x1)
      val (x2, l2) = l1.pop
      assert-equal(2, x2)
      val (x3, _) = l2.pop
      assert-equal(3, x3)
    },
    test("reverse > Double reverse") {
      val (x1, l1) = from-list([1, 2, 3]).reverse.reverse.pop
      assert-equal(3, x1)
      val (x2, l2) = l1.pop
      assert-equal(2, x2)
      val (x3, _) = l2.pop
      assert-equal(1, x3)
    },
  ])
