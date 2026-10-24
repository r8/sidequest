import test
import proverb

pub fun main()
  run([
    test("zero pieces") { assert-equal([], recite([])) },
    test("one piece") { assert-equal(["And all for the want of a nail."], recite(["nail"])) },
    test("two pieces") { assert-equal(["For want of a nail the shoe was lost.", "And all for the want of a nail."], recite(["nail", "shoe"])) },
    test("three pieces") {
      assert-equal([
        "For want of a nail the shoe was lost.",
        "For want of a shoe the horse was lost.",
        "And all for the want of a nail.",
      ], recite(["nail", "shoe", "horse"]))
    },
    test("full proverb") {
      assert-equal([
        "For want of a nail the shoe was lost.",
        "For want of a shoe the horse was lost.",
        "For want of a horse the rider was lost.",
        "For want of a rider the message was lost.",
        "For want of a message the battle was lost.",
        "For want of a battle the kingdom was lost.",
        "And all for the want of a nail.",
      ], recite(["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"]))
    },
    test("four pieces modernized") {
      assert-equal([
        "For want of a pin the gun was lost.",
        "For want of a gun the soldier was lost.",
        "For want of a soldier the battle was lost.",
        "And all for the want of a pin.",
      ], recite(["pin", "gun", "soldier", "battle"]))
    },
  ])
