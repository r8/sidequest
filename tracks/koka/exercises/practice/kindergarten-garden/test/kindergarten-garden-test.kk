import test
import kindergarten-garden

val full-garden = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"

pub fun main()
  run([
    test("partial garden > garden with single student") {
      assert-equal([Radishes, Clover, Grass, Grass], plants("RC\nGG", "Alice"))
    },
    test("partial garden > different garden with single student") {
      assert-equal([Violets, Clover, Radishes, Clover], plants("VC\nRC", "Alice"))
    },
    test("partial garden > garden with two students") {
      assert-equal([Clover, Grass, Radishes, Clover], plants("VVCG\nVVRC", "Bob"))
    },
    test("partial garden > multiple students for the same garden with three students > second student's garden") {
      assert-equal([Clover, Clover, Clover, Clover], plants("VVCCGG\nVVCCGG", "Bob"))
    },
    test("partial garden > multiple students for the same garden with three students > third student's garden") {
      assert-equal([Grass, Grass, Grass, Grass], plants("VVCCGG\nVVCCGG", "Charlie"))
    },
    test("full garden > for Alice, first student's garden") {
      assert-equal([Violets, Radishes, Violets, Radishes], plants(full-garden, "Alice"))
    },
    test("full garden > for Bob, second student's garden") {
      assert-equal([Clover, Grass, Clover, Clover], plants(full-garden, "Bob"))
    },
    test("full garden > for Charlie") {
      assert-equal([Violets, Violets, Clover, Grass], plants(full-garden, "Charlie"))
    },
    test("full garden > for David") {
      assert-equal([Radishes, Violets, Clover, Radishes], plants(full-garden, "David"))
    },
    test("full garden > for Eve") {
      assert-equal([Clover, Grass, Radishes, Grass], plants(full-garden, "Eve"))
    },
    test("full garden > for Fred") {
      assert-equal([Grass, Clover, Violets, Clover], plants(full-garden, "Fred"))
    },
    test("full garden > for Ginny") {
      assert-equal([Clover, Grass, Grass, Clover], plants(full-garden, "Ginny"))
    },
    test("full garden > for Harriet") {
      assert-equal([Violets, Radishes, Radishes, Violets], plants(full-garden, "Harriet"))
    },
    test("full garden > for Ileana") {
      assert-equal([Grass, Clover, Violets, Clover], plants(full-garden, "Ileana"))
    },
    test("full garden > for Joseph") {
      assert-equal([Violets, Clover, Violets, Grass], plants(full-garden, "Joseph"))
    },
    test("full garden > for Kincaid, second to last student's garden") {
      assert-equal([Grass, Clover, Clover, Grass], plants(full-garden, "Kincaid"))
    },
    test("full garden > for Larry, last student's garden") {
      assert-equal([Grass, Violets, Clover, Violets], plants(full-garden, "Larry"))
    },
  ])
