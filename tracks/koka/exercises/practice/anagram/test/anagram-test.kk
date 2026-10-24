import test
import anagram

pub fun main()
  run([
    test("no matches") { assert-equal([], find-anagrams("diaper", ["hello", "world", "zombies", "pants"])) },
    test("detects two anagrams") { assert-equal(["lemons", "melons"], find-anagrams("solemn", ["lemons", "cherry", "melons"])) },
    test("does not detect anagram subsets") { assert-equal([], find-anagrams("good", ["dog", "goody"])) },
    test("detects anagram") { assert-equal(["inlets"], find-anagrams("listen", ["enlists", "google", "inlets", "banana"])) },
    test("detects three anagrams") {
      assert-equal(["gallery", "regally", "largely"],
                   find-anagrams("allergy", ["gallery", "ballerina", "regally", "clergy", "largely", "leading"]))
    },
    test("detects multiple anagrams with different case") { assert-equal(["Eons", "ONES"], find-anagrams("nose", ["Eons", "ONES"])) },
    test("does not detect non-anagrams with identical checksum") { assert-equal([], find-anagrams("mass", ["last"])) },
    test("detects anagrams case-insensitively") {
      assert-equal(["Carthorse"], find-anagrams("Orchestra", ["cashregister", "Carthorse", "radishes"]))
    },
    test("detects anagrams using case-insensitive subject") {
      assert-equal(["carthorse"], find-anagrams("Orchestra", ["cashregister", "carthorse", "radishes"]))
    },
    test("detects anagrams using case-insensitive possible matches") {
      assert-equal(["Carthorse"], find-anagrams("orchestra", ["cashregister", "Carthorse", "radishes"]))
    },
    test("does not detect an anagram if the original word is repeated") { assert-equal([], find-anagrams("go", ["goGoGO"])) },
    test("anagrams must use all letters exactly once") { assert-equal([], find-anagrams("tapper", ["patter"])) },
    test("words are not anagrams of themselves") { assert-equal([], find-anagrams("BANANA", ["BANANA"])) },
    test("words are not anagrams of themselves even if letter case is partially different") {
      assert-equal([], find-anagrams("BANANA", ["Banana"]))
    },
    test("words are not anagrams of themselves even if letter case is completely different") {
      assert-equal([], find-anagrams("BANANA", ["banana"]))
    },
    test("words other than themselves can be anagrams") { assert-equal(["Silent"], find-anagrams("LISTEN", ["LISTEN", "Silent"])) },
    test("handles case of greek letters") { assert-equal(["ΒΓΑ", "γβα"], find-anagrams("ΑΒΓ", ["ΒΓΑ", "ΒΓΔ", "γβα", "αβγ"])) },
    test("different characters may have the same bytes") { assert-equal([], find-anagrams("a⬂", ["€a"])) },
  ])
