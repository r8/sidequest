import test
import rna-transcription

pub fun main()
  run([
    test("Empty RNA sequence") { assert-equal("", to-rna("")) },
    test("RNA complement of cytosine is guanine") { assert-equal("G", to-rna("C")) },
    test("RNA complement of guanine is cytosine") { assert-equal("C", to-rna("G")) },
    test("RNA complement of thymine is adenine") { assert-equal("A", to-rna("T")) },
    test("RNA complement of adenine is uracil") { assert-equal("U", to-rna("A")) },
    test("RNA complement") { assert-equal("UGCACCAGAAUU", to-rna("ACGTGGTCTTAA")) },
  ])
