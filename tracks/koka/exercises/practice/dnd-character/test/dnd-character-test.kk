import test
import dnd-character
import std/num/random

fun abilities(c : character) : list<int>
  [c.strength, c.dexterity, c.constitution, c.intelligence, c.wisdom, c.charisma]

fun assert-valid-ability(score : int) : exn ()
  if score < 3 || score > 18 then throw("expected an ability score from 3 to 18, got " ++ score.show, ExnAssert)

fun assert-valid-character(c : character) : exn ()
  abilities(c).foreach(assert-valid-ability)
  assert-equal(10 + modifier(c.constitution), c.hitpoints)

pub fun main()
  run([
    test("ability modifier > ability modifier for score 3 is -4") { assert-equal(-4, modifier(3)) },
    test("ability modifier > ability modifier for score 4 is -3") { assert-equal(-3, modifier(4)) },
    test("ability modifier > ability modifier for score 5 is -3") { assert-equal(-3, modifier(5)) },
    test("ability modifier > ability modifier for score 6 is -2") { assert-equal(-2, modifier(6)) },
    test("ability modifier > ability modifier for score 7 is -2") { assert-equal(-2, modifier(7)) },
    test("ability modifier > ability modifier for score 8 is -1") { assert-equal(-1, modifier(8)) },
    test("ability modifier > ability modifier for score 9 is -1") { assert-equal(-1, modifier(9)) },
    test("ability modifier > ability modifier for score 10 is 0") { assert-equal(0, modifier(10)) },
    test("ability modifier > ability modifier for score 11 is 0") { assert-equal(0, modifier(11)) },
    test("ability modifier > ability modifier for score 12 is +1") { assert-equal(1, modifier(12)) },
    test("ability modifier > ability modifier for score 13 is +1") { assert-equal(1, modifier(13)) },
    test("ability modifier > ability modifier for score 14 is +2") { assert-equal(2, modifier(14)) },
    test("ability modifier > ability modifier for score 15 is +2") { assert-equal(2, modifier(15)) },
    test("ability modifier > ability modifier for score 16 is +3") { assert-equal(3, modifier(16)) },
    test("ability modifier > ability modifier for score 17 is +3") { assert-equal(3, modifier(17)) },
    test("ability modifier > ability modifier for score 18 is +4") { assert-equal(4, modifier(18)) },
    test("random ability is within range") { strong-random { for(1000) fn(_) assert-valid-ability(ability()) } },
    test("random character is valid") { strong-random { for(1000) fn(_) assert-valid-character(character()) } },
    test("each ability is only calculated once") { strong-random { val c = character(); abilities(c).foreach(fn(a) assert-equal(a, a)) } },
  ])
