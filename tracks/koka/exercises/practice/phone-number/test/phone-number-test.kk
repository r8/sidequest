import test
import phone-number

pub fun main()
  run([
    test("cleans the number") { assert-equal("2234567890", clean("(223) 456-7890")) },
    test("cleans numbers with dots") { assert-equal("2234567890", clean("223.456.7890")) },
    test("cleans numbers with multiple spaces") { assert-equal("2234567890", clean("223 456   7890   ")) },
    test("invalid when 9 digits") { assert-throws("must not be fewer than 10 digits") { clean("123456789") } },
    test("invalid when 11 digits does not start with a 1") { assert-throws("11 digits must start with 1") { clean("22234567890") } },
    test("valid when 11 digits and starting with 1") { assert-equal("2234567890", clean("12234567890")) },
    test("valid when 11 digits and starting with 1 even with punctuation") { assert-equal("2234567890", clean("+1 (223) 456-7890")) },
    test("invalid when more than 11 digits") { assert-throws("must not be greater than 11 digits") { clean("321234567890") } },
    test("invalid with letters") { assert-throws("letters not permitted") { clean("523-abc-7890") } },
    test("invalid with punctuations") { assert-throws("punctuations not permitted") { clean("523-@:!-7890") } },
    test("invalid if area code starts with 0") { assert-throws("area code cannot start with zero") { clean("(023) 456-7890") } },
    test("invalid if area code starts with 1") { assert-throws("area code cannot start with one") { clean("(123) 456-7890") } },
    test("invalid if exchange code starts with 0") { assert-throws("exchange code cannot start with zero") { clean("(223) 056-7890") } },
    test("invalid if exchange code starts with 1") { assert-throws("exchange code cannot start with one") { clean("(223) 156-7890") } },
    test("invalid if area code starts with 0 on valid 11-digit number") { assert-throws("area code cannot start with zero") { clean("1 (023) 456-7890") } },
    test("invalid if area code starts with 1 on valid 11-digit number") { assert-throws("area code cannot start with one") { clean("1 (123) 456-7890") } },
    test("invalid if exchange code starts with 0 on valid 11-digit number") { assert-throws("exchange code cannot start with zero") { clean("1 (223) 056-7890") } },
    test("invalid if exchange code starts with 1 on valid 11-digit number") { assert-throws("exchange code cannot start with one") { clean("1 (223) 156-7890") } },
  ])
