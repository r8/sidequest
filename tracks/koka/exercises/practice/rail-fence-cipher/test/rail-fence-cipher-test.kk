import test
import rail-fence-cipher

pub fun main()
  run([
    test("encode > encode with two rails") { assert-equal("XXXXXXXXXOOOOOOOOO", encode("XOXOXOXOXOXOXOXOXO", 2)) },
    test("encode > encode with three rails") { assert-equal("WECRLTEERDSOEEFEAOCAIVDEN", encode("WEAREDISCOVEREDFLEEATONCE", 3)) },
    test("encode > encode with ending in the middle") { assert-equal("ESXIEECSR", encode("EXERCISES", 4)) },
    test("decode > decode with three rails") { assert-equal("THEDEVILISINTHEDETAILS", decode("TEITELHDVLSNHDTISEIIEA", 3)) },
    test("decode > decode with five rails") { assert-equal("EXERCISMISAWESOME", decode("EIEXMSMESAORIWSCE", 5)) },
    test("decode > decode with six rails") { assert-equal("112358132134558914423337761098715972584418167651094617711286", decode("133714114238148966225439541018335470986172518171757571896261", 6)) },
    // Not in the canonical data: one rail never zig-zags, so the text reads straight through.
    test("encode > encode with one rail") { assert-equal("ABCDE", encode("ABCDE", 1)) },
    test("decode > decode with one rail") { assert-equal("ABCDE", decode("ABCDE", 1)) },
  ])
