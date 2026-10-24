import test
import storage-crates

// The item in a crate, if any, so the tests can compare crates.
fun contents(c : crate<a>) : maybe<a>
  match c
    Holding(item) -> Just(item)
    Vacant -> Nothing

pub fun main()
  run([
    test("1. swap a number and a string") { assert-equal(("harp", 1), swap((1, "harp"))) },
    test("1. swap two numbers") { assert-equal((9, 4), swap((4, 9))) },
    test("1. swap a list and a bool") { assert-equal((True, [1, 2]), swap(([1, 2], True))) },
    test("2. fill crates with strings") {
      assert-equal([Just("turnip"), Just("harp")], fill(["turnip", "harp"]).map(contents))
    },
    test("2. fill crates with numbers") { assert-equal([Just(3), Just(1), Just(2)], fill([3, 1, 2]).map(contents)) },
    test("2. nothing to fill") { assert-equal(0, fill([] : list<int>).length) },
    test("3. unpack a crate of numbers") { assert-equal(7, Holding(7).unpack(0)) },
    test("3. unpack a crate of strings") { assert-equal("harp", Holding("harp").unpack("none")) },
    test("3. unpack a vacant crate") { assert-equal("none", Vacant.unpack("none")) },
    test("4. repack into another type") {
      assert-equal(Just("3 kg"), Holding(3).repack(fn(n) n.show ++ " kg").contents)
    },
    test("4. repack into the same type") {
      assert-equal(Just(30), Holding(3).repack(fn(n) n * 10).contents)
    },
    test("4. repack a vacant crate") {
      assert-true((Vacant : crate<int>).repack(fn(n) n * 10).is-vacant)
    },
    test("5. a crate holds the item") {
      assert-true([Vacant, Holding("harp")].holds("harp", fn(x, y) x == y))
    },
    test("5. no crate holds the item") {
      assert-false([Holding(1), Vacant, Holding(2)].holds(3, fn(x, y) x == y))
    },
    test("5. using the given comparison") {
      assert-true([Holding("HARP")].holds("harp", fn(x, y) x.to-lower == y.to-lower))
    },
    test("5. no crates at all") { assert-false(([] : list<crate<int>>).holds(1, fn(x, y) x == y)) },
  ])
