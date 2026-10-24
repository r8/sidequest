import test
import food-chain

val multiple-verses =
  [
    "I know an old lady who swallowed a fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a spider.",
    "It wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a bird.",
    "How absurd to swallow a bird!",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
  ]

val full-song =
  [
    "I know an old lady who swallowed a fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a spider.",
    "It wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a bird.",
    "How absurd to swallow a bird!",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a cat.",
    "Imagine that, to swallow a cat!",
    "She swallowed the cat to catch the bird.",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a dog.",
    "What a hog, to swallow a dog!",
    "She swallowed the dog to catch the cat.",
    "She swallowed the cat to catch the bird.",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a goat.",
    "Just opened her throat and swallowed a goat!",
    "She swallowed the goat to catch the dog.",
    "She swallowed the dog to catch the cat.",
    "She swallowed the cat to catch the bird.",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a cow.",
    "I don't know how she swallowed a cow!",
    "She swallowed the cow to catch the goat.",
    "She swallowed the goat to catch the dog.",
    "She swallowed the dog to catch the cat.",
    "She swallowed the cat to catch the bird.",
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "She swallowed the spider to catch the fly.",
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "",
    "I know an old lady who swallowed a horse.",
    "She's dead, of course!",
  ]

pub fun main()
  run([
    test("fly") {
      assert-equal([
        "I know an old lady who swallowed a fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(1, 1))
    },
    test("spider") {
      assert-equal([
        "I know an old lady who swallowed a spider.",
        "It wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(2, 2))
    },
    test("bird") {
      assert-equal([
        "I know an old lady who swallowed a bird.",
        "How absurd to swallow a bird!",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(3, 3))
    },
    test("cat") {
      assert-equal([
        "I know an old lady who swallowed a cat.",
        "Imagine that, to swallow a cat!",
        "She swallowed the cat to catch the bird.",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(4, 4))
    },
    test("dog") {
      assert-equal([
        "I know an old lady who swallowed a dog.",
        "What a hog, to swallow a dog!",
        "She swallowed the dog to catch the cat.",
        "She swallowed the cat to catch the bird.",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(5, 5))
    },
    test("goat") {
      assert-equal([
        "I know an old lady who swallowed a goat.",
        "Just opened her throat and swallowed a goat!",
        "She swallowed the goat to catch the dog.",
        "She swallowed the dog to catch the cat.",
        "She swallowed the cat to catch the bird.",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(6, 6))
    },
    test("cow") {
      assert-equal([
        "I know an old lady who swallowed a cow.",
        "I don't know how she swallowed a cow!",
        "She swallowed the cow to catch the goat.",
        "She swallowed the goat to catch the dog.",
        "She swallowed the dog to catch the cat.",
        "She swallowed the cat to catch the bird.",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
        "She swallowed the spider to catch the fly.",
        "I don't know why she swallowed the fly. Perhaps she'll die.",
      ], recite(7, 7))
    },
    test("horse") { assert-equal(["I know an old lady who swallowed a horse.", "She's dead, of course!"], recite(8, 8)) },
    test("multiple verses") { assert-equal(multiple-verses, recite(1, 3)) },
    test("full song") { assert-equal(full-song, recite(1, 8)) },
  ])
