import test
import step-counter

pub fun main()
  run([
    test("1. no days") { assert-equal(0, total-steps([])) },
    test("1. one day") { assert-equal(8000, total-steps([8000])) },
    test("1. several days") { assert-equal(25000, total-steps([4000, 12000, 9000])) },
    test("2. no days") { assert-equal(0, goal-days([], 5000)) },
    test("2. meeting the goal exactly counts") { assert-equal(2, goal-days([4000, 12000, 9000], 9000)) },
    test("2. no day meets a high goal") { assert-equal(0, goal-days([4000, 12000, 9000], 20000)) },
    test("2. every day meets a low goal") { assert-equal(3, goal-days([4000, 12000, 9000], 100)) },
    test("3. no days") { assert-equal(0, longest-streak([], 10000)) },
    test("3. the longest of several streaks") {
      assert-equal(3, longest-streak([10000, 11000, 2000, 10000, 10500, 12000, 300], 10000))
    },
    test("3. a streak at the start") { assert-equal(2, longest-streak([10000, 11000, 2000, 10000], 10000)) },
    test("3. no day meets the goal") { assert-equal(0, longest-streak([10, 20, 30], 10000)) },
    test("3. every day meets the goal") { assert-equal(4, longest-streak([5, 6, 7, 8], 5)) },
    test("4. no days") { assert-equal(0, best-day([])) },
    test("4. a single day") { assert-equal(1, best-day([300])) },
    test("4. the best day") { assert-equal(3, best-day([4000, 9000, 12000, 500])) },
    test("4. the earliest of tied days") { assert-equal(2, best-day([4000, 12000, 9000, 12000])) },
    test("4. a day without steps") { assert-equal(1, best-day([0])) },
    test("5. a few weeks") { assert-equal(3, weeks-to-goal(6000, 1500, 10000)) },
    test("5. reaching the goal exactly") { assert-equal(2, weeks-to-goal(6000, 2000, 10000)) },
    test("5. already there") { assert-equal(0, weeks-to-goal(12000, 1000, 10000)) },
    test("5. a long way to go") { assert-equal(100, weeks-to-goal(0, 100, 10000)) },
  ])
