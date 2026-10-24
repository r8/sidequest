import test
import reverse-string

pub fun main()
  run([
    test("an empty string") { assert-equal("", reverse("")) },
    test("a word") { assert-equal("tobor", reverse("robot")) },
    test("a capitalized word") { assert-equal("nemaR", reverse("Ramen")) },
    test("a sentence with punctuation") { assert-equal("!yrgnuh m'I", reverse("I'm hungry!")) },
    test("a palindrome") { assert-equal("racecar", reverse("racecar")) },
    test("an even-sized word") { assert-equal("reward", reverse("drawer")) },
    test("wide characters") { assert-equal("猫子", reverse("子猫")) },
  ])
