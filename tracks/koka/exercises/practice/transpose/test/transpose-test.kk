import test
import transpose

val first-line-longer-than-second-line =
  ["TT", "hh", "ee", "  ", "ff", "oi", "uf", "rt", "th", "h ", " l", "li", "in", "ne", "e.", "."]

val second-line-longer-than-first-line =
  ["TT", "hh", "ee", "  ", "fs", "ie", "rc", "so", "tn", " d", "l ", "il", "ni", "en", ".e", " ."]

val mixed-line-length =
  [
    "TAAA",
    "h   ",
    "elll",
    " ooi",
    "lnnn",
    "ogge",
    "n e.",
    "glr",
    "ei ",
    "snl",
    "tei",
    " .n",
    "l e",
    "i .",
    "n",
    "e",
    ".",
  ]

pub fun main()
  run([
    test("empty string") { assert-equal([], transpose([])) },
    test("two characters in a row") { assert-equal(["A", "1"], transpose(["A1"])) },
    test("two characters in a column") { assert-equal(["A1"], transpose(["A", "1"])) },
    test("simple") { assert-equal(["A1", "B2", "C3"], transpose(["ABC", "123"])) },
    test("single line") { assert-equal(["S", "i", "n", "g", "l", "e", " ", "l", "i", "n", "e", "."], transpose(["Single line."])) },
    test("first line longer than second line") { assert-equal(first-line-longer-than-second-line, transpose(["The fourth line.", "The fifth line."])) },
    test("second line longer than first line") { assert-equal(second-line-longer-than-first-line, transpose(["The first line.", "The second line."])) },
    test("mixed line length") { assert-equal(mixed-line-length, transpose(["The longest line.", "A long line.", "A longer line.", "A line."])) },
    test("square") { assert-equal(["HEART", "EMBER", "ABUSE", "RESIN", "TREND"], transpose(["HEART", "EMBER", "ABUSE", "RESIN", "TREND"])) },
    test("rectangle") { assert-equal(["FOBS", "RULE", "ATOP", "CLOT", "TIME", "UNIT", "RENT", "EDGE"], transpose(["FRACTURE", "OUTLINED", "BLOOMING", "SEPTETTE"])) },
    test("triangle") { assert-equal(["TEASER", " EASER", "  ASER", "   SER", "    ER", "     R"], transpose(["T", "EE", "AAA", "SSSS", "EEEEE", "RRRRRR"])) },
    test("jagged triangle") { assert-equal(["123456", "1 3456", "  3456", "  3 56", "    56", "    5"], transpose(["11", "2", "3333", "444", "555555", "66666"])) },
  ])
