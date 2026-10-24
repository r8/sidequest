import test
import affine-cipher

pub fun main()
  run([
    test("encode > encode yes") { assert-equal("xbt", encode("yes", 5, 7)) },
    test("encode > encode no") { assert-equal("fu", encode("no", 15, 18)) },
    test("encode > encode OMG") { assert-equal("lvz", encode("OMG", 21, 3)) },
    test("encode > encode O M G") { assert-equal("hjp", encode("O M G", 25, 47)) },
    test("encode > encode mindblowingly") { assert-equal("rzcwa gnxzc dgt", encode("mindblowingly", 11, 15)) },
    test("encode > encode numbers") { assert-equal("jqgjc rw123 jqgjc rw", encode("Testing,1 2 3, testing.", 3, 4)) },
    test("encode > encode deep thought") { assert-equal("iynia fdqfb ifje", encode("Truth is fiction.", 5, 17)) },
    test("encode > encode all the letters") { assert-equal("swxtj npvyk lruol iejdc blaxk swxmh qzglf", encode("The quick brown fox jumps over the lazy dog.", 17, 33)) },
    test("encode > encode with a not coprime to m") { assert-throws("a and m must be coprime.") { encode("This is a test.", 6, 17) } },
    test("decode > decode exercism") { assert-equal("exercism", decode("tytgn fjr", 3, 7)) },
    test("decode > decode a sentence") { assert-equal("anobstacleisoftenasteppingstone", decode("qdwju nqcro muwhn odqun oppmd aunwd o", 19, 16)) },
    test("decode > decode numbers") { assert-equal("testing123testing", decode("odpoz ub123 odpoz ub", 25, 7)) },
    test("decode > decode all the letters") { assert-equal("thequickbrownfoxjumpsoverthelazydog", decode("swxtj npvyk lruol iejdc blaxk swxmh qzglf", 17, 33)) },
    test("decode > decode with no spaces in input") { assert-equal("thequickbrownfoxjumpsoverthelazydog", decode("swxtjnpvyklruoliejdcblaxkswxmhqzglf", 17, 33)) },
    test("decode > decode with too many spaces") { assert-equal("jollygreengiant", decode("vszzm    cly   yd cg    qdp", 15, 16)) },
    test("decode > decode with a not coprime to m") { assert-throws("a and m must be coprime.") { decode("Test", 13, 5) } },
  ])
