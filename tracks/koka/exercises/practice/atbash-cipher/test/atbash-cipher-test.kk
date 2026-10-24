import test
import atbash-cipher

pub fun main()
  run([
    test("encode > encode yes") { assert-equal("bvh", encode("yes")) },
    test("encode > encode no") { assert-equal("ml", encode("no")) },
    test("encode > encode OMG") { assert-equal("lnt", encode("OMG")) },
    test("encode > encode spaces") { assert-equal("lnt", encode("O M G")) },
    test("encode > encode mindblowingly") { assert-equal("nrmwy oldrm tob", encode("mindblowingly")) },
    test("encode > encode numbers") { assert-equal("gvhgr mt123 gvhgr mt", encode("Testing,1 2 3, testing.")) },
    test("encode > encode deep thought") { assert-equal("gifgs rhurx grlm", encode("Truth is fiction.")) },
    test("encode > encode all the letters") { assert-equal("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt", encode("The quick brown fox jumps over the lazy dog.")) },
    test("decode > decode exercism") { assert-equal("exercism", decode("vcvix rhn")) },
    test("decode > decode a sentence") { assert-equal("anobstacleisoftenasteppingstone", decode("zmlyh gzxov rhlug vmzhg vkkrm thglm v")) },
    test("decode > decode numbers") { assert-equal("testing123testing", decode("gvhgr mt123 gvhgr mt")) },
    test("decode > decode all the letters") { assert-equal("thequickbrownfoxjumpsoverthelazydog", decode("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt")) },
    test("decode > decode with too many spaces") { assert-equal("exercism", decode("vc vix    r hn")) },
    test("decode > decode with no spaces") { assert-equal("anobstacleisoftenasteppingstone", decode("zmlyhgzxovrhlugvmzhgvkkrmthglmv")) },
  ])
