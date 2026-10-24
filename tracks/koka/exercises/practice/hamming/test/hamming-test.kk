import test
import hamming

pub fun main()
  run([
    test("empty strands") { assert-equal(0, distance("", "")) },
    test("single letter identical strands") { assert-equal(0, distance("A", "A")) },
    test("single letter different strands") { assert-equal(1, distance("G", "T")) },
    test("long identical strands") { assert-equal(0, distance("GGACTGAAATCTG", "GGACTGAAATCTG")) },
    test("long different strands") { assert-equal(9, distance("GGACGGATTCTG", "AGGACGGATTCT")) },
    test("disallow first strand longer") { assert-throws("strands must be of equal length") { distance("AATG", "AAA") } },
    test("disallow second strand longer") { assert-throws("strands must be of equal length") { distance("ATA", "AGTG") } },
    test("disallow empty first strand") { assert-throws("strands must be of equal length") { distance("", "G") } },
    test("disallow empty second strand") { assert-throws("strands must be of equal length") { distance("G", "") } },
  ])
