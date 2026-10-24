import test
import name-badges

pub fun main()
  run([
    test("1. a badge") { assert-equal("Ana Lima, ACME", badge("Ana Lima", "Acme")) },
    test("1. a company already in capitals") { assert-equal("Li Wei, IBM", badge("Li Wei", "IBM")) },
    test("1. a company in lower case") { assert-equal("Sam Okafor, GLOBEX CORP", badge("Sam Okafor", "globex corp")) },
    test("2. a plain name") { assert-equal("Ana Lima", display-name("Ana Lima")) },
    test("2. a name with spaces around it") { assert-equal("Ana Lima", display-name("  Ana Lima ")) },
    test("2. no name") { assert-equal("Guest", display-name("")) },
    test("2. only spaces") { assert-equal("Guest", display-name("   ")) },
    test("3. a one-digit table") { assert-equal("T07-3", table-label(7, 3)) },
    test("3. a two-digit table") { assert-equal("T12-10", table-label(12, 10)) },
    test("3. a three-digit table") { assert-equal("T100-1", table-label(100, 1)) },
    test("4. a short word") { assert-equal("******\n* Hi *\n******", framed("Hi")) },
    test("4. a name") { assert-equal("************\n* Ana Lima *\n************", framed("Ana Lima")) },
    test("4. nothing") { assert-equal("****\n*  *\n****", framed("")) },
    test("5. an organiser") { assert-true(is-staff("mei@kokaconf.org")) },
    test("5. a visitor") { assert-false(is-staff("mei@example.com")) },
    test("5. the domain elsewhere in the address") { assert-false(is-staff("kokaconf.org@example.com")) },
  ])
