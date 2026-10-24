import test
import acronym

pub fun main()
  run([
    test("basic") { assert-equal("PNG", abbreviate("Portable Network Graphics")) },
    test("lowercase words") { assert-equal("ROR", abbreviate("Ruby on Rails")) },
    test("punctuation") { assert-equal("FIFO", abbreviate("First In, First Out")) },
    test("all caps word") { assert-equal("GIMP", abbreviate("GNU Image Manipulation Program")) },
    test("punctuation without whitespace") { assert-equal("CMOS", abbreviate("Complementary metal-oxide semiconductor")) },
    test("very long abbreviation") { assert-equal("ROTFLSHTMDCOALM", abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")) },
    test("consecutive delimiters") { assert-equal("SIMUFTA", abbreviate("Something - I made up from thin air")) },
    test("apostrophes") { assert-equal("HC", abbreviate("Halley's Comet")) },
    test("underscore emphasis") { assert-equal("TRNT", abbreviate("The Road _Not_ Taken")) },
    // Not in the canonical data: any whitespace separates words, not just spaces.
    test("tabs and newlines separate words") { assert-equal("PNG", abbreviate("Portable\tNetwork\nGraphics")) },
    // Not in the canonical data: words may start with non-ASCII letters, which are capitalized too.
    test("non-ASCII letters") { assert-equal("ÉV", abbreviate("élan Vital")) },
  ])
