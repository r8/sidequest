import test
import flower-field

pub fun main()
  run([
    test("no rows") { assert-equal([], annotate([])) },
    test("no columns") { assert-equal([""], annotate([""])) },
    test("no flowers") { assert-equal(["   ", "   ", "   "], annotate(["   ", "   ", "   "])) },
    test("garden full of flowers") { assert-equal(["***", "***", "***"], annotate(["***", "***", "***"])) },
    test("flower surrounded by spaces") { assert-equal(["111", "1*1", "111"], annotate(["   ", " * ", "   "])) },
    test("space surrounded by flowers") { assert-equal(["***", "*8*", "***"], annotate(["***", "* *", "***"])) },
    test("horizontal line") { assert-equal(["1*2*1"], annotate([" * * "])) },
    test("horizontal line, flowers at edges") { assert-equal(["*1 1*"], annotate(["*   *"])) },
    test("vertical line") { assert-equal(["1", "*", "2", "*", "1"], annotate([" ", "*", " ", "*", " "])) },
    test("vertical line, flowers at edges") { assert-equal(["*", "1", " ", "1", "*"], annotate(["*", " ", " ", " ", "*"])) },
    test("cross") {
      assert-equal([" 2*2 ", "25*52", "*****", "25*52", " 2*2 "], annotate(["  *  ", "  *  ", "*****", "  *  ", "  *  "]))
    },
    test("large garden") {
      assert-equal(["1*22*1", "12*322", " 123*2", "112*4*", "1*22*2", "111111"],
                   annotate([" *  * ", "  *   ", "    * ", "   * *", " *  * ", "      "]))
    },
    test("multiple adjacent flowers") { assert-equal(["1**1"], annotate([" ** "])) },
  ])
