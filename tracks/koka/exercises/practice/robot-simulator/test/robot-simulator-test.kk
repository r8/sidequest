import test
import robot-simulator

pub fun main()
  run([
    test("Create robot > at origin facing north") { assert-equal(Robot((0, 0), North), create((0, 0), North)) },
    test("Create robot > at negative position facing south") { assert-equal(Robot((-1, -1), South), create((-1, -1), South)) },
    test("Rotating clockwise > changes north to east") { assert-equal(Robot((0, 0), East), Robot((0, 0), North).move("R")) },
    test("Rotating clockwise > changes east to south") { assert-equal(Robot((0, 0), South), Robot((0, 0), East).move("R")) },
    test("Rotating clockwise > changes south to west") { assert-equal(Robot((0, 0), West), Robot((0, 0), South).move("R")) },
    test("Rotating clockwise > changes west to north") { assert-equal(Robot((0, 0), North), Robot((0, 0), West).move("R")) },
    test("Rotating counter-clockwise > changes north to west") { assert-equal(Robot((0, 0), West), Robot((0, 0), North).move("L")) },
    test("Rotating counter-clockwise > changes west to south") { assert-equal(Robot((0, 0), South), Robot((0, 0), West).move("L")) },
    test("Rotating counter-clockwise > changes south to east") { assert-equal(Robot((0, 0), East), Robot((0, 0), South).move("L")) },
    test("Rotating counter-clockwise > changes east to north") { assert-equal(Robot((0, 0), North), Robot((0, 0), East).move("L")) },
    test("Moving forward one > facing north increments Y") { assert-equal(Robot((0, 1), North), Robot((0, 0), North).move("A")) },
    test("Moving forward one > facing south decrements Y") { assert-equal(Robot((0, -1), South), Robot((0, 0), South).move("A")) },
    test("Moving forward one > facing east increments X") { assert-equal(Robot((1, 0), East), Robot((0, 0), East).move("A")) },
    test("Moving forward one > facing west decrements X") { assert-equal(Robot((-1, 0), West), Robot((0, 0), West).move("A")) },
    test("Follow series of instructions > moving east and north from README") { assert-equal(Robot((9, 4), West), Robot((7, 3), North).move("RAALAL")) },
    test("Follow series of instructions > moving west and north") { assert-equal(Robot((-4, 1), West), Robot((0, 0), North).move("LAAARALA")) },
    test("Follow series of instructions > moving west and south") { assert-equal(Robot((-3, -8), South), Robot((2, -7), East).move("RRAAAAALA")) },
    test("Follow series of instructions > moving east and north") { assert-equal(Robot((11, 5), North), Robot((8, 4), South).move("LAAARRRALLLL")) },
  ])
