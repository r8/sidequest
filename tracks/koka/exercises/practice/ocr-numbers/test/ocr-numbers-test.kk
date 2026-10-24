import test
import ocr-numbers

pub fun main()
  run([
    test("Recognizes 0") { assert-equal("0", convert([" _ ", "| |", "|_|", "   "])) },
    test("Recognizes 1") { assert-equal("1", convert(["   ", "  |", "  |", "   "])) },
    test("Unreadable but correctly sized inputs return ?") { assert-equal("?", convert(["   ", "  _", "  |", "   "])) },
    test("Input with a number of lines that is not a multiple of four raises an error") { assert-throws("Number of input lines is not a multiple of four") { convert([" _ ", "| |", "   "]) } },
    test("Input with a number of columns that is not a multiple of three raises an error") { assert-throws("Number of input columns is not a multiple of three") { convert(["    ", "   |", "   |", "    "]) } },
    test("Recognizes 110101100") {
      assert-equal("110101100", convert([
        "       _     _        _  _ ",
        "  |  || |  || |  |  || || |",
        "  |  ||_|  ||_|  |  ||_||_|",
        "                           ",
      ]))
    },
    test("Garbled numbers in a string are replaced with ?") {
      assert-equal("11?10?1?0", convert([
        "       _     _           _ ",
        "  |  || |  || |     || || |",
        "  |  | _|  ||_|  |  ||_||_|",
        "                           ",
      ]))
    },
    test("Recognizes 2") { assert-equal("2", convert([" _ ", " _|", "|_ ", "   "])) },
    test("Recognizes 3") { assert-equal("3", convert([" _ ", " _|", " _|", "   "])) },
    test("Recognizes 4") { assert-equal("4", convert(["   ", "|_|", "  |", "   "])) },
    test("Recognizes 5") { assert-equal("5", convert([" _ ", "|_ ", " _|", "   "])) },
    test("Recognizes 6") { assert-equal("6", convert([" _ ", "|_ ", "|_|", "   "])) },
    test("Recognizes 7") { assert-equal("7", convert([" _ ", "  |", "  |", "   "])) },
    test("Recognizes 8") { assert-equal("8", convert([" _ ", "|_|", "|_|", "   "])) },
    test("Recognizes 9") { assert-equal("9", convert([" _ ", "|_|", " _|", "   "])) },
    test("Recognizes string of decimal numbers") {
      assert-equal("1234567890", convert([
        "    _  _     _  _  _  _  _  _ ",
        "  | _| _||_||_ |_   ||_||_|| |",
        "  ||_  _|  | _||_|  ||_| _||_|",
        "                              ",
      ]))
    },
    test("Numbers separated by empty lines are recognized. Lines are joined by commas.") {
      assert-equal("123,456,789", convert([
        "    _  _ ",
        "  | _| _|",
        "  ||_  _|",
        "         ",
        "    _  _ ",
        "|_||_ |_ ",
        "  | _||_|",
        "         ",
        " _  _  _ ",
        "  ||_||_|",
        "  ||_| _|",
        "         ",
      ]))
    },
  ])
