import test
import bob

pub fun main()
  run([
    test("asking a question") { assert-equal("Sure.", response("Does this cryogenic chamber make me look fat?")) },
    test("shouting") { assert-equal("Whoa, chill out!", response("WATCH OUT!")) },
    test("forceful question") { assert-equal("Calm down, I know what I'm doing!", response("WHAT'S GOING ON?")) },
    test("silence") { assert-equal("Fine. Be that way!", response("")) },
    test("stating something") { assert-equal("Whatever.", response("Tom-ay-to, tom-aaaah-to.")) },
    test("asking a numeric question") { assert-equal("Sure.", response("You are, what, like 15?")) },
    test("asking gibberish") { assert-equal("Sure.", response("fffbbcbeab?")) },
    test("question with no letters") { assert-equal("Sure.", response("4?")) },
    test("non-letters with question") { assert-equal("Sure.", response(":) ?")) },
    test("prattling on") { assert-equal("Sure.", response("Wait! Hang on. Are you going to be OK?")) },
    test("ending with whitespace") { assert-equal("Sure.", response("Okay if like my  spacebar  quite a bit?   ")) },
    test("multiple line question") { assert-equal("Sure.", response("\nDoes this cryogenic chamber make\n me look fat?")) },
    test("shouting gibberish") { assert-equal("Whoa, chill out!", response("FCECDFCAAB")) },
    test("shouting a statement containing a question mark") { assert-equal("Whoa, chill out!", response("DO LIONS EAT PEOPLE? AHHHHH.")) },
    test("shouting numbers") { assert-equal("Whoa, chill out!", response("1, 2, 3 GO!")) },
    test("shouting with special characters") { assert-equal("Whoa, chill out!", response("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")) },
    test("shouting with no exclamation mark") { assert-equal("Whoa, chill out!", response("I HATE THE DENTIST")) },
    test("prolonged silence") { assert-equal("Fine. Be that way!", response("          ")) },
    test("alternate silence") { assert-equal("Fine. Be that way!", response("\t\t\t\t\t\t\t\t\t\t")) },
    test("other whitespace") { assert-equal("Fine. Be that way!", response("\n\r \t")) },
    test("talking forcefully") { assert-equal("Whatever.", response("Hi there!")) },
    test("using acronyms in regular speech") { assert-equal("Whatever.", response("It's OK if you don't want to go work for NASA.")) },
    test("no letters") { assert-equal("Whatever.", response("1, 2, 3")) },
    test("statement containing question mark") { assert-equal("Whatever.", response("Ending with ? means a question.")) },
    test("starting with whitespace") { assert-equal("Whatever.", response("         hmmmmmmm...")) },
    test("non-question ending with whitespace") { assert-equal("Whatever.", response("This is a statement ending with whitespace      ")) },
    // Not in the canonical data: a non-ASCII lower-case letter means it isn't shouting.
    test("non-ASCII lowercase letter") { assert-equal("Whatever.", response("ÜMLäÜTS!")) },
    // Not in the canonical data: shouting in capitals outside ASCII.
    test("shouting in another script") { assert-equal("Whoa, chill out!", response("ПРИВЕТ!")) },
    // Not in the canonical data: Unicode whitespace, such as a no-break space, is silence too.
    test("no-break and ideographic spaces are silence") { assert-equal("Fine. Be that way!", response("\u00A0\u3000")) },
  ])
