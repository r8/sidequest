import test
import linked-list

fun empty-list() : exn linked-list<int>
  from-list([])

pub fun main()
  run([
    test("pop gets element from the list") {
      val (x, _) = empty-list().push(7).pop
      assert-equal(7, x)
    },
    test("push/pop respectively add/remove at the end of the list") {
      val (x1, l1) = empty-list().push(11).push(13).pop
      assert-equal(13, x1)
      val (x2, _) = l1.pop
      assert-equal(11, x2)
    },
    test("shift gets an element from the list") {
      val (x, _) = empty-list().push(17).shift
      assert-equal(17, x)
    },
    test("shift gets first element from the list") {
      val (x1, l1) = empty-list().push(23).push(5).shift
      assert-equal(23, x1)
      val (x2, _) = l1.shift
      assert-equal(5, x2)
    },
    test("unshift adds element at start of the list") {
      val (x1, l1) = empty-list().unshift(23).unshift(5).shift
      assert-equal(5, x1)
      val (x2, _) = l1.shift
      assert-equal(23, x2)
    },
    test("pop, push, shift, and unshift can be used in any order") {
      val (x1, l1) = empty-list().push(1).push(2).pop
      assert-equal(2, x1)
      val (x2, l2) = l1.push(3).shift
      assert-equal(1, x2)
      val (x3, l3) = l2.unshift(4).push(5).shift
      assert-equal(4, x3)
      val (x4, l4) = l3.pop
      assert-equal(5, x4)
      val (x5, _) = l4.shift
      assert-equal(3, x5)
    },
    test("count an empty list") { assert-equal(0, empty-list().count) },
    test("count a list with items") { assert-equal(2, empty-list().push(37).push(1).count) },
    test("count is correct after mutation") {
      val l1 = empty-list().push(31)
      assert-equal(1, l1.count)
      val l2 = l1.unshift(43)
      assert-equal(2, l2.count)
      val (_, l3) = l2.shift
      assert-equal(1, l3.count)
      val (_, l4) = l3.pop
      assert-equal(0, l4.count)
    },
    test("popping to empty doesn't break the list") {
      val (_, l1) = empty-list().push(41).push(59).pop
      val (_, l2) = l1.pop
      val l3 = l2.push(47)
      assert-equal(1, l3.count)
      val (x, _) = l3.pop
      assert-equal(47, x)
    },
    test("shifting to empty doesn't break the list") {
      val (_, l1) = empty-list().push(41).push(59).shift
      val (_, l2) = l1.shift
      val l3 = l2.push(47)
      assert-equal(1, l3.count)
      val (x, _) = l3.shift
      assert-equal(47, x)
    },
    test("deletes the only element") { assert-equal(0, empty-list().push(61).delete(61).count) },
    test("deletes the element with the specified value from the list") {
      val l = empty-list().push(71).push(83).push(79).delete(83)
      assert-equal(2, l.count)
      val (x1, l1) = l.pop
      assert-equal(79, x1)
      val (x2, _) = l1.shift
      assert-equal(71, x2)
    },
    test("deletes the element with the specified value from the list, re-assigns tail") {
      val l = empty-list().push(71).push(83).push(79).delete(83)
      assert-equal(2, l.count)
      val (x1, l1) = l.pop
      assert-equal(79, x1)
      val (x2, _) = l1.pop
      assert-equal(71, x2)
    },
    test("deletes the element with the specified value from the list, re-assigns head") {
      val l = empty-list().push(71).push(83).push(79).delete(83)
      assert-equal(2, l.count)
      val (x1, l1) = l.shift
      assert-equal(71, x1)
      val (x2, _) = l1.shift
      assert-equal(79, x2)
    },
    test("deletes the first of two elements") {
      val l = empty-list().push(97).push(101).delete(97)
      assert-equal(1, l.count)
      val (x, _) = l.pop
      assert-equal(101, x)
    },
    test("deletes the second of two elements") {
      val l = empty-list().push(97).push(101).delete(101)
      assert-equal(1, l.count)
      val (x, _) = l.pop
      assert-equal(97, x)
    },
    test("delete does not modify the list if the element is not found") {
      assert-equal(1, empty-list().push(89).delete(103).count)
    },
    test("deletes only the first occurrence") {
      val l = empty-list().push(73).push(9).push(9).push(107).delete(9)
      assert-equal(3, l.count)
      val (x1, l1) = l.pop
      assert-equal(107, x1)
      val (x2, l2) = l1.pop
      assert-equal(9, x2)
      val (x3, _) = l2.pop
      assert-equal(73, x3)
    },
  ])
