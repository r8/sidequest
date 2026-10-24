import test
import train-shunting

// Parks the wagons into an empty yard, in order.
fun yard-of(wagons : list<int>) : exn yard
  wagons.foldl(Buffer, fn(y, w) y.park(w))

pub fun main()
  run([
    test("1. turns a train around") { assert-equal([3, 2, 1], reverse-train([1, 2, 3])) },
    test("1. a single wagon") { assert-equal(["tanker"], reverse-train(["tanker"])) },
    test("1. no wagons") { assert-equal([], reverse-train([] : list<int>)) },
    test("1. a train that is still in use elsewhere is left as it was") {
      val train = [7, 8, 9]
      assert-equal(([9, 8, 7], [7, 8, 9]), (reverse-train(train), train))
    },
    test("2. adds the offset to every wagon") { assert-equal([101, 102, 107], renumber([1, 2, 7], 100)) },
    test("2. a negative offset") { assert-equal([0, 5], renumber([10, 15], -10)) },
    test("2. no wagons") { assert-equal([], renumber([], 3)) },
    test("3. swaps the wagons pairwise") { assert-equal([2, 1, 4, 3], swap-pairs([1, 2, 3, 4])) },
    test("3. the last wagon of an odd train stays put") {
      assert-equal(["b", "a", "d", "c", "e"], swap-pairs(["a", "b", "c", "d", "e"]))
    },
    test("3. a single wagon") { assert-equal([5], swap-pairs([5])) },
    test("3. no wagons") { assert-equal([], swap-pairs([] : list<int>)) },
    test("4. uncouples a wagon") { assert-equal([1, 3], uncouple([1, 2, 3], 2)) },
    test("4. uncouples every wagon with that number") { assert-equal([4, 5], uncouple([9, 4, 9, 9, 5, 9], 9)) },
    test("4. a number that is not in the train") { assert-equal([1, 2], uncouple([1, 2], 3)) },
    test("4. uncoupling everything") { assert-equal([], uncouple([6, 6], 6)) },
    test("5. parks a wagon in an empty yard") { assert-equal([4], Buffer.park(4).tracks) },
    test("5. the yard keeps its wagons in order") { assert-equal([1, 3, 5, 8], yard-of([5, 1, 8, 3]).tracks) },
    test("5. a wagon is only parked once") { assert-equal([2, 7], yard-of([7, 2, 7, 2]).tracks) },
    test("5. smaller numbers go left, larger right") {
      val shaped = match yard-of([5, 1, 8])
        Siding(Siding(Buffer, 1, Buffer), 5, Siding(Buffer, 8, Buffer)) -> True
        _ -> False
      assert-true(shaped)
    },
  ])
