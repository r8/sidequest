import test
import nucleotide-count

pub fun main()
  run([
    test("empty strand") {
      assert-equal([('A', 0), ('C', 0), ('G', 0), ('T', 0)], nucleotide-counts(""))
    },
    test("can count one nucleotide in single-character input") {
      assert-equal([('A', 0), ('C', 0), ('G', 1), ('T', 0)], nucleotide-counts("G"))
    },
    test("strand with repeated nucleotide") {
      assert-equal([('A', 0), ('C', 0), ('G', 7), ('T', 0)], nucleotide-counts("GGGGGGG"))
    },
    test("strand with multiple nucleotides") {
      assert-equal([('A', 20), ('C', 12), ('G', 17), ('T', 21)],
                   nucleotide-counts("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))
    },
    test("strand with invalid nucleotides") {
      assert-throws("Invalid nucleotide in strand") { nucleotide-counts("AGXXACT") }
    },
  ])
