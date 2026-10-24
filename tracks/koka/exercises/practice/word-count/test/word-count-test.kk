import test
import word-count

pub fun main()
  run([
    test("count one word") {
      assert-equal([("word", 1)], count-words("word"))
    },
    test("count one of each word") {
      assert-equal([("each", 1), ("of", 1), ("one", 1)], count-words("one of each"))
    },
    test("multiple occurrences of a word") {
      assert-equal([("blue", 1), ("fish", 4), ("one", 1), ("red", 1), ("two", 1)], count-words("one fish two fish red fish blue fish"))
    },
    test("handles cramped lists") {
      assert-equal([("one", 1), ("three", 1), ("two", 1)], count-words("one,two,three"))
    },
    test("handles expanded lists") {
      assert-equal([("one", 1), ("three", 1), ("two", 1)], count-words("one,\ntwo,\nthree"))
    },
    test("ignore punctuation") {
      assert-equal([("as", 1), ("car", 1), ("carpet", 1), ("java", 1), ("javascript", 1)], count-words("car: carpet as java: javascript!!&@$%^&"))
    },
    test("include numbers") {
      assert-equal([("1", 1), ("2", 1), ("testing", 2)], count-words("testing, 1, 2 testing"))
    },
    test("normalize case") {
      assert-equal([("go", 3), ("stop", 2)], count-words("go Go GO Stop stop"))
    },
    test("with apostrophes") {
      assert-equal([("cry", 1), ("don't", 2), ("first", 1), ("getting", 1), ("it", 1), ("laugh", 1), ("then", 1), ("you're", 1)], count-words("'First: don't laugh. Then: don't cry. You're getting it.'"))
    },
    test("with quotations") {
      assert-equal([("and", 1), ("between", 1), ("can't", 1), ("joe", 1), ("large", 2), ("tell", 1)], count-words("Joe can't tell between 'large' and large."))
    },
    test("substrings from the beginning") {
      assert-equal([("a", 1), ("and", 1), ("app", 1), ("apple", 1), ("between", 1), ("can't", 1), ("joe", 1), ("tell", 1)], count-words("Joe can't tell between app, apple and a."))
    },
    test("multiple spaces not detected as a word") {
      assert-equal([("multiple", 1), ("whitespaces", 1)], count-words(" multiple   whitespaces"))
    },
    test("alternating word separators not detected as a word") {
      assert-equal([("one", 1), ("three", 1), ("two", 1)], count-words(",\n,one,\n ,two \n 'three'"))
    },
    test("quotation for word with apostrophe") {
      assert-equal([("can", 1), ("can't", 2)], count-words("can, can't, 'can't'"))
    },
  ])
