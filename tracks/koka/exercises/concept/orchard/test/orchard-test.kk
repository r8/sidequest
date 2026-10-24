import test
import orchard

pub fun main()
  run([
    test("1. baskets with more than 20 apples") { assert-equal(2, count-if([12, 30, 25], fn(apples) apples > 20)) },
    test("1. baskets with an even number of apples") { assert-equal(1, count-if([12, 31, 25], is-even)) },
    test("1. no baskets pass") { assert-equal(0, count-if([1, 2, 3], fn(apples) apples > 3)) },
    test("1. no baskets at all") { assert-equal(0, count-if([], fn(_) True)) },
    test("2. some apples bruised") { assert-equal([8, 0, 21], bruise([12, 3, 25], 4)) },
    test("2. no apples bruised") { assert-equal([5, 6], bruise([5, 6], 0)) },
    test("2. every basket emptied") { assert-equal([0, 0], bruise([2, 9], 10)) },
    test("2. no baskets") { assert-equal([], bruise([], 3)) },
    test("3. some baskets ready") { assert-equal([30, 25], ready-to-sell([12, 30, 25], 20)) },
    test("3. a basket of exactly the minimum") { assert-equal([20], ready-to-sell([20, 19], 20)) },
    test("3. no basket ready") { assert-equal([], ready-to-sell([3, 4], 10)) },
    test("4. every basket full") { assert-true(all-full([40, 40, 40], 40)) },
    test("4. one basket short") { assert-false(all-full([40, 40, 39], 40)) },
    test("4. no baskets are all full") { assert-true(all-full([], 40)) },
    test("5. crates for three baskets") { assert-equal(8, crates-needed([12, 30, 25], 10)) },
    test("5. baskets that fill their crates") { assert-equal(3, crates-needed([20, 10], 10)) },
    test("5. an empty basket needs no crate") { assert-equal(1, crates-needed([0, 7], 10)) },
    test("5. no baskets") { assert-equal(0, crates-needed([], 6)) },
  ])
