import test
import house

pub fun main()
  run([
    test("verse one - the house that jack built") { assert-equal(["This is the house that Jack built."], recite(1, 1)) },
    test("verse two - the malt that lay") { assert-equal(["This is the malt that lay in the house that Jack built."], recite(2, 2)) },
    test("verse three - the rat that ate") { assert-equal(["This is the rat that ate the malt that lay in the house that Jack built."], recite(3, 3)) },
    test("verse four - the cat that killed") { assert-equal(["This is the cat that killed the rat that ate the malt that lay in the house that Jack built."], recite(4, 4)) },
    test("verse five - the dog that worried") {
      assert-equal([
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(5, 5))
    },
    test("verse six - the cow with the crumpled horn") {
      assert-equal([
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(6, 6))
    },
    test("verse seven - the maiden all forlorn") {
      assert-equal([
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(7, 7))
    },
    test("verse eight - the man all tattered and torn") {
      assert-equal([
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(8, 8))
    },
    test("verse nine - the priest all shaven and shorn") {
      assert-equal([
        "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(9, 9))
    },
    test("verse 10 - the rooster that crowed in the morn") {
      assert-equal([
        "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(10, 10))
    },
    test("verse 11 - the farmer sowing his corn") {
      assert-equal([
        "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(11, 11))
    },
    test("verse 12 - the horse and the hound and the horn") {
      assert-equal([
        "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(12, 12))
    },
    test("multiple verses") {
      assert-equal([
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(4, 8))
    },
    test("full rhyme") {
      assert-equal([
        "This is the house that Jack built.",
        "This is the malt that lay in the house that Jack built.",
        "This is the rat that ate the malt that lay in the house that Jack built.",
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
      ], recite(1, 12))
    },
  ])
