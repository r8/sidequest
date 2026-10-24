import std/num/random
import test
import simple-cipher

// A fresh key from the system's random source.
fun fresh-key() : <ndet,exn> string
  strong-random(random-key)

fun front(s : string, n : int) : string
  s.list.take(n).string

pub fun main()
  run([
    test("Random key cipher > Can encode") {
      val key = fresh-key()
      assert-equal(key.front(10), encode(key, "aaaaaaaaaa"))
    },
    test("Random key cipher > Can decode") {
      val key = fresh-key()
      assert-equal("aaaaaaaaaa", decode(key, key.front(10)))
    },
    test("Random key cipher > Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method") {
      val key = fresh-key()
      assert-equal("abcdefghij", decode(key, encode(key, "abcdefghij")))
    },
    test("Random key cipher > Key is made only of lowercase letters") {
      // Over many samples: every key has at least 100 lowercase letters, the keys differ,
      // and together they use the whole alphabet.
      val keys = list(1, 100).map(fn(_) fresh-key())
      keys.foreach fn(key)
        assert-true(key.count >= 100)
        assert-true(key.list.all(fn(c) c >= 'a' && c <= 'z'))
      assert-true(keys.any(fn(key) key != keys.head.default("")))
      val used = keys.join.list
      assert-true(list('a', 'z').all(fn(c) used.any(fn(u) u == c)))
    },
    test("Substitution cipher > Can encode") { assert-equal("abcdefghij", encode("abcdefghij", "aaaaaaaaaa")) },
    test("Substitution cipher > Can decode") { assert-equal("aaaaaaaaaa", decode("abcdefghij", "abcdefghij")) },
    test("Substitution cipher > Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method") {
      assert-equal("abcdefghij", decode("abcdefghij", encode("abcdefghij", "abcdefghij")))
    },
    test("Substitution cipher > Can double shift encode") { assert-equal("qayaeaagaciai", encode("iamapandabear", "iamapandabear")) },
    test("Substitution cipher > Can wrap on encode") { assert-equal("zabcdefghi", encode("abcdefghij", "zzzzzzzzzz")) },
    test("Substitution cipher > Can wrap on decode") { assert-equal("zzzzzzzzzz", decode("abcdefghij", "zabcdefghi")) },
    test("Substitution cipher > Can encode messages longer than the key") { assert-equal("iboaqcnecbfcr", encode("abc", "iamapandabear")) },
    test("Substitution cipher > Can decode messages longer than the key") { assert-equal("iamapandabear", decode("abc", "iboaqcnecbfcr")) },
  ])
