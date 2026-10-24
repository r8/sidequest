import test
import pocket-calculator

pub fun main()
  run([
    test("1. a single number") { assert-equal(42, evaluate(Num(42))) },
    test("1. a sum") { assert-equal(5, evaluate(Add(Num(2), Num(3)))) },
    test("1. a product of a sum") { assert-equal(14, evaluate(Mul(Num(2), Add(Num(3), Num(4))))) },
    test("1. a negation") { assert-equal(-14, evaluate(Neg(Mul(Num(2), Add(Num(3), Num(4)))))) },
    test("1. a negative number in a sum") { assert-equal(1, evaluate(Add(Num(-2), Num(3)))) },
    test("2. a single number") { assert-equal(1, count-numbers(Num(9))) },
    test("2. a nested expression") { assert-equal(3, count-numbers(Add(Num(1), Mul(Num(2), Num(3))))) },
    test("2. a negation adds no number") { assert-equal(2, count-numbers(Neg(Add(Num(1), Neg(Num(2)))))) },
    test("3. a number") { assert-equal("7", display(Num(7))) },
    test("3. a sum") { assert-equal("(1 + 2)", display(Add(Num(1), Num(2)))) },
    test("3. a nested expression") { assert-equal("(1 + (2 * 3))", display(Add(Num(1), Mul(Num(2), Num(3))))) },
    test("3. negations") { assert-equal("-(-4 * 5)", display(Neg(Mul(Neg(Num(4)), Num(5))))) },
    test("4. a number") { assert-equal(1, depth(Num(3))) },
    test("4. a sum") { assert-equal(2, depth(Add(Num(1), Num(2)))) },
    test("4. the deeper side counts") { assert-equal(3, depth(Add(Num(1), Mul(Num(2), Num(3))))) },
    test("4. negations nest") { assert-equal(4, depth(Neg(Neg(Mul(Num(1), Num(2)))))) },
    test("5. nothing to drop") { assert-equal(Mul(Num(5), Num(2)), drop-zeros(Mul(Num(5), Num(2)))) },
    test("5. zero on the left") { assert-equal(Mul(Num(5), Num(2)), drop-zeros(Mul(Add(Num(0), Num(5)), Num(2)))) },
    test("5. zero on the right") { assert-equal(Neg(Num(3)), drop-zeros(Neg(Add(Num(3), Num(0))))) },
    test("5. zeros that only appear once others are dropped") {
      assert-equal(Num(7), drop-zeros(Add(Num(7), Add(Num(0), Num(0)))))
    },
    test("5. a product by zero stays") { assert-equal(Mul(Num(0), Num(4)), drop-zeros(Mul(Num(0), Num(4)))) },
  ])
