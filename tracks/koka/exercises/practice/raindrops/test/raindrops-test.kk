import test
import raindrops

pub fun main()
  run([
    test("the sound for 1 is 1") { assert-equal("1", convert(1)) },
    test("the sound for 3 is Pling") { assert-equal("Pling", convert(3)) },
    test("the sound for 5 is Plang") { assert-equal("Plang", convert(5)) },
    test("the sound for 7 is Plong") { assert-equal("Plong", convert(7)) },
    test("the sound for 6 is Pling as it has a factor 3") { assert-equal("Pling", convert(6)) },
    test("2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base") { assert-equal("8", convert(8)) },
    test("the sound for 9 is Pling as it has a factor 3") { assert-equal("Pling", convert(9)) },
    test("the sound for 10 is Plang as it has a factor 5") { assert-equal("Plang", convert(10)) },
    test("the sound for 14 is Plong as it has a factor of 7") { assert-equal("Plong", convert(14)) },
    test("the sound for 15 is PlingPlang as it has factors 3 and 5") { assert-equal("PlingPlang", convert(15)) },
    test("the sound for 21 is PlingPlong as it has factors 3 and 7") { assert-equal("PlingPlong", convert(21)) },
    test("the sound for 25 is Plang as it has a factor 5") { assert-equal("Plang", convert(25)) },
    test("the sound for 27 is Pling as it has a factor 3") { assert-equal("Pling", convert(27)) },
    test("the sound for 35 is PlangPlong as it has factors 5 and 7") { assert-equal("PlangPlong", convert(35)) },
    test("the sound for 49 is Plong as it has a factor 7") { assert-equal("Plong", convert(49)) },
    test("the sound for 52 is 52") { assert-equal("52", convert(52)) },
    test("the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7") { assert-equal("PlingPlangPlong", convert(105)) },
    test("the sound for 3125 is Plang as it has a factor 5") { assert-equal("Plang", convert(3125)) },
  ])
