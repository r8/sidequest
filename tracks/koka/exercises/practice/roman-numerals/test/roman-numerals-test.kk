import test
import roman-numerals

pub fun main()
  run([
    test("1 is I") { assert-equal("I", roman(1)) },
    test("2 is II") { assert-equal("II", roman(2)) },
    test("3 is III") { assert-equal("III", roman(3)) },
    test("4 is IV") { assert-equal("IV", roman(4)) },
    test("5 is V") { assert-equal("V", roman(5)) },
    test("6 is VI") { assert-equal("VI", roman(6)) },
    test("9 is IX") { assert-equal("IX", roman(9)) },
    test("16 is XVI") { assert-equal("XVI", roman(16)) },
    test("27 is XXVII") { assert-equal("XXVII", roman(27)) },
    test("48 is XLVIII") { assert-equal("XLVIII", roman(48)) },
    test("49 is XLIX") { assert-equal("XLIX", roman(49)) },
    test("59 is LIX") { assert-equal("LIX", roman(59)) },
    test("66 is LXVI") { assert-equal("LXVI", roman(66)) },
    test("93 is XCIII") { assert-equal("XCIII", roman(93)) },
    test("141 is CXLI") { assert-equal("CXLI", roman(141)) },
    test("163 is CLXIII") { assert-equal("CLXIII", roman(163)) },
    test("166 is CLXVI") { assert-equal("CLXVI", roman(166)) },
    test("402 is CDII") { assert-equal("CDII", roman(402)) },
    test("575 is DLXXV") { assert-equal("DLXXV", roman(575)) },
    test("666 is DCLXVI") { assert-equal("DCLXVI", roman(666)) },
    test("911 is CMXI") { assert-equal("CMXI", roman(911)) },
    test("1024 is MXXIV") { assert-equal("MXXIV", roman(1024)) },
    test("1666 is MDCLXVI") { assert-equal("MDCLXVI", roman(1666)) },
    test("3000 is MMM") { assert-equal("MMM", roman(3000)) },
    test("3001 is MMMI") { assert-equal("MMMI", roman(3001)) },
    test("3888 is MMMDCCCLXXXVIII") { assert-equal("MMMDCCCLXXXVIII", roman(3888)) },
    test("3999 is MMMCMXCIX") { assert-equal("MMMCMXCIX", roman(3999)) },
  ])
