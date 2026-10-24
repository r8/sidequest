import test
import matching-brackets

pub fun main()
  run([
    test("paired square brackets") { assert-true(is-paired("[]")) },
    test("empty string") { assert-true(is-paired("")) },
    test("unpaired brackets") { assert-false(is-paired("[[")) },
    test("wrong ordered brackets") { assert-false(is-paired("}{")) },
    test("wrong closing bracket") { assert-false(is-paired("{]")) },
    test("paired with whitespace") { assert-true(is-paired("{ }")) },
    test("partially paired brackets") { assert-false(is-paired("{[])")) },
    test("simple nested brackets") { assert-true(is-paired("{[]}")) },
    test("several paired brackets") { assert-true(is-paired("{}[]")) },
    test("paired and nested brackets") { assert-true(is-paired("([{}({}[])])")) },
    test("unopened closing brackets") { assert-false(is-paired("{[)][]}")) },
    test("unpaired and nested brackets") { assert-false(is-paired("([{])")) },
    test("paired and wrong nested brackets") { assert-false(is-paired("[({]})")) },
    test("paired and wrong nested brackets but innermost are correct") { assert-false(is-paired("[({}])")) },
    test("paired and incomplete brackets") { assert-false(is-paired("{}[")) },
    test("too many closing brackets") { assert-false(is-paired("[]]")) },
    test("early unexpected brackets") { assert-false(is-paired(")()")) },
    test("early mismatched brackets") { assert-false(is-paired("{)()")) },
    test("math expression") { assert-true(is-paired("(((185 + 223.85) * 15) - 543)/2")) },
    test("complex latex expression") { assert-true(is-paired("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")) },
  ])
