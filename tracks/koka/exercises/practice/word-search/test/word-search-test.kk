import test
import word-search

// The ten-line grid that most cases search.
val puzzle = [
  "jefblpepre",
  "camdcimgtc",
  "oivokprjsm",
  "pbwasqroua",
  "rixilelhrs",
  "wolcqlirpc",
  "screeaumgr",
  "alxhpburyi",
  "jalaycalmp",
  "clojurermt",
]

fun at(start : (int, int), end : (int, int)) : maybe<word-location>
  Just(Word-location(start, end))

pub fun main()
  run([
    test("Should accept an initial game grid and a target search word") {
      assert-equal([("clojure", Nothing)], search(["jefblpepre"], ["clojure"]))
    },
    test("Should locate one word written left to right") {
      assert-equal([("clojure", at((1, 1), (1, 7)))], search(["clojurermt"], ["clojure"]))
    },
    test("Should locate the same word written left to right in a different position") {
      assert-equal([("clojure", at((1, 3), (1, 9)))], search(["mtclojurer"], ["clojure"]))
    },
    test("Should locate a different left to right word") {
      assert-equal([("coffee", at((1, 1), (1, 6)))], search(["coffeelplx"], ["coffee"]))
    },
    test("Should locate that different left to right word in a different position") {
      assert-equal([("coffee", at((1, 2), (1, 7)))], search(["xcoffeezlp"], ["coffee"]))
    },
    test("Should locate a left to right word in two line grid") {
      assert-equal([("clojure", at((2, 2), (2, 8)))], search(["jefblpepre", "tclojurerm"], ["clojure"]))
    },
    test("Should locate a left to right word in three line grid") {
      val grid = [
        "camdcimgtc",
        "jefblpepre",
        "clojurermt",
      ]
      assert-equal([("clojure", at((3, 1), (3, 7)))], search(grid, ["clojure"]))
    },
    test("Should locate a left to right word in ten line grid") {
      assert-equal([("clojure", at((10, 1), (10, 7)))], search(puzzle, ["clojure"]))
    },
    test("Should locate that left to right word in a different position in a ten line grid") {
      val grid = [
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "screeaumgr",
        "alxhpburyi",
        "clojurermt",
        "jalaycalmp",
      ]
      assert-equal([("clojure", at((9, 1), (9, 7)))], search(grid, ["clojure"]))
    },
    test("Should locate a different left to right word in a ten line grid") {
      val grid = [
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "fortranftw",
        "alxhpburyi",
        "clojurermt",
        "jalaycalmp",
      ]
      assert-equal([("fortran", at((7, 1), (7, 7)))], search(grid, ["fortran"]))
    },
    test("Should locate multiple words") {
      val grid = [
        "jefblpepre",
        "camdcimgtc",
        "oivokprjsm",
        "pbwasqroua",
        "rixilelhrs",
        "wolcqlirpc",
        "fortranftw",
        "alxhpburyi",
        "jalaycalmp",
        "clojurermt",
      ]
      assert-equal([("fortran", at((7, 1), (7, 7))), ("clojure", at((10, 1), (10, 7)))], search(grid, ["fortran", "clojure"]))
    },
    test("Should locate a single word written right to left") {
      assert-equal([("elixir", at((1, 6), (1, 1)))], search(["rixilelhrs"], ["elixir"]))
    },
    test("Should locate multiple words written in different horizontal directions") {
      assert-equal([("elixir", at((5, 6), (5, 1))), ("clojure", at((10, 1), (10, 7)))], search(puzzle, ["elixir", "clojure"]))
    },
    test("Should locate words written top to bottom") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript"]))
    },
    test("Should locate words written bottom to top") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust"]))
    },
    test("Should locate words written top left to bottom right") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
        ("java", at((1, 1), (4, 4))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust", "java"]))
    },
    test("Should locate words written bottom right to top left") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
        ("java", at((1, 1), (4, 4))),
        ("lua", at((9, 8), (7, 6))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust", "java", "lua"]))
    },
    test("Should locate words written bottom left to top right") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
        ("java", at((1, 1), (4, 4))),
        ("lua", at((9, 8), (7, 6))),
        ("lisp", at((6, 3), (3, 6))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp"]))
    },
    test("Should locate words written top right to bottom left") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
        ("java", at((1, 1), (4, 4))),
        ("lua", at((9, 8), (7, 6))),
        ("lisp", at((6, 3), (3, 6))),
        ("ruby", at((6, 8), (9, 5))),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby"]))
    },
    test("Should fail to locate a word that is not in the puzzle") {
      val expected = [
        ("clojure", at((10, 1), (10, 7))),
        ("elixir", at((5, 6), (5, 1))),
        ("ecmascript", at((1, 10), (10, 10))),
        ("rust", at((5, 9), (2, 9))),
        ("java", at((1, 1), (4, 4))),
        ("lua", at((9, 8), (7, 6))),
        ("lisp", at((6, 3), (3, 6))),
        ("ruby", at((6, 8), (9, 5))),
        ("haskell", Nothing),
      ]
      assert-equal(expected, search(puzzle, ["clojure", "elixir", "ecmascript", "rust", "java", "lua", "lisp", "ruby", "haskell"]))
    },
    test("Should fail to locate words that are not on horizontal, vertical, or diagonal lines") {
      val expected = [
        ("aef", Nothing),
        ("ced", Nothing),
        ("abf", Nothing),
        ("cbd", Nothing),
      ]
      assert-equal(expected, search(["abc", "def"], ["aef", "ced", "abf", "cbd"]))
    },
    test("Should not concatenate different lines to find a horizontal word") {
      assert-equal([("elixir", Nothing)], search(["abceli", "xirdfg"], ["elixir"]))
    },
    test("Should not wrap around horizontally to find a word") {
      assert-equal([("lisp", Nothing)], search(["silabcdefp"], ["lisp"]))
    },
    test("Should not wrap around vertically to find a word") {
      assert-equal([("rust", Nothing)], search(["s", "u", "r", "a", "b", "c", "t"], ["rust"]))
    },
  ])
