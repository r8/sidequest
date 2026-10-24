import test
import pig-latin

pub fun main()
  run([
    test("ay is added to words that start with vowels > word beginning with a") { assert-equal("appleay", translate("apple")) },
    test("ay is added to words that start with vowels > word beginning with e") { assert-equal("earay", translate("ear")) },
    test("ay is added to words that start with vowels > word beginning with i") { assert-equal("iglooay", translate("igloo")) },
    test("ay is added to words that start with vowels > word beginning with o") { assert-equal("objectay", translate("object")) },
    test("ay is added to words that start with vowels > word beginning with u") { assert-equal("underay", translate("under")) },
    test("ay is added to words that start with vowels > word beginning with a vowel and followed by a qu") { assert-equal("equalay", translate("equal")) },
    test("first letter and ay are moved to the end of words that start with consonants > word beginning with p") { assert-equal("igpay", translate("pig")) },
    test("first letter and ay are moved to the end of words that start with consonants > word beginning with k") { assert-equal("oalakay", translate("koala")) },
    test("first letter and ay are moved to the end of words that start with consonants > word beginning with x") { assert-equal("enonxay", translate("xenon")) },
    test("first letter and ay are moved to the end of words that start with consonants > word beginning with q without a following u") { assert-equal("atqay", translate("qat")) },
    test("first letter and ay are moved to the end of words that start with consonants > word beginning with consonant and vowel containing qu") { assert-equal("iquidlay", translate("liquid")) },
    test("some letter clusters are treated like a single consonant > word beginning with ch") { assert-equal("airchay", translate("chair")) },
    test("some letter clusters are treated like a single consonant > word beginning with qu") { assert-equal("eenquay", translate("queen")) },
    test("some letter clusters are treated like a single consonant > word beginning with qu and a preceding consonant") { assert-equal("aresquay", translate("square")) },
    test("some letter clusters are treated like a single consonant > word beginning with th") { assert-equal("erapythay", translate("therapy")) },
    test("some letter clusters are treated like a single consonant > word beginning with thr") { assert-equal("ushthray", translate("thrush")) },
    test("some letter clusters are treated like a single consonant > word beginning with sch") { assert-equal("oolschay", translate("school")) },
    test("some letter clusters are treated like a single vowel > word beginning with yt") { assert-equal("yttriaay", translate("yttria")) },
    test("some letter clusters are treated like a single vowel > word beginning with xr") { assert-equal("xrayay", translate("xray")) },
    test("position of y in a word determines if it is a consonant or a vowel > y is treated like a consonant at the beginning of a word") { assert-equal("ellowyay", translate("yellow")) },
    test("position of y in a word determines if it is a consonant or a vowel > y is treated like a vowel at the end of a consonant cluster") { assert-equal("ythmrhay", translate("rhythm")) },
    test("position of y in a word determines if it is a consonant or a vowel > y as second letter in two letter word") { assert-equal("ymay", translate("my")) },
    test("phrases are translated > a whole phrase") { assert-equal("ickquay astfay unray", translate("quick fast run")) },
    // Not in the canonical data: words are separated by any whitespace, which the translation keeps.
    test("spacing between words is kept") { assert-equal("ymay  ogday\tickquay", translate("my  dog\tquick")) },
  ])
