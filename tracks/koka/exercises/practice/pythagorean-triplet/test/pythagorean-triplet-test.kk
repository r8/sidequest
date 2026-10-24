import test
import pythagorean-triplet

pub fun main()
  run([
    test("triplets whose sum is 12") { assert-equal([(3, 4, 5)], triplets-with-sum(12)) },
    test("triplets whose sum is 108") { assert-equal([(27, 36, 45)], triplets-with-sum(108)) },
    test("triplets whose sum is 1000") { assert-equal([(200, 375, 425)], triplets-with-sum(1000)) },
    test("no matching triplets for 1001") { assert-equal([], triplets-with-sum(1001)) },
    test("returns all matching triplets") { assert-equal([(9, 40, 41), (15, 36, 39)], triplets-with-sum(90)) },
    test("several matching triplets") {
      assert-equal([(40, 399, 401), (56, 390, 394), (105, 360, 375), (120, 350, 370),
                    (140, 336, 364), (168, 315, 357), (210, 280, 350), (240, 252, 348)],
                   triplets-with-sum(840))
    },
    test("triplets for large number") {
      assert-equal([(1200, 14375, 14425), (1875, 14000, 14125), (5000, 12000, 13000),
                    (6000, 11250, 12750), (7500, 10000, 12500)],
                   triplets-with-sum(30000))
    },
  ])
