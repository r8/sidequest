import test
import many-worlds

// A quest: at the first branch the hero sets out (and gains luck) or stays home (and loses some);
// out in the world, the hero meets a dragon or finds a treasure.
fun quest() : <branch,luck> string
  if branch() then
    change-luck(2)
    if branch() then "dragon" else "treasure"
  else
    change-luck(-1)
    "home"

// A day at the market: each of two branches that goes True wins a coin of luck; the ending is the luck at the end.
fun market() : <branch,luck> int
  if branch() then change-luck(1)
  if branch() then change-luck(1)
  luck()

pub fun main()
  run([
    test("1. a story with one branch has two endings") {
      assert-equal(["left", "right"], all-endings { if branch() then "left" else "right" })
    },
    test("1. a story without branches has one ending") { assert-equal([7], all-endings { 7 }) },
    test("1. two branches make four worlds") {
      assert-equal([(True, True), (True, False), (False, True), (False, False)], all-endings { val a = branch(); (a, branch()) })
    },
    test("1. a later branch only splits the worlds that reach it") {
      assert-equal(["out, left", "out, right", "in"], all-endings {
        if branch() then (if branch() then "out, left" else "out, right") else "in"
      })
    },
    test("2. changes and reads the luck") { assert-equal((14, 7), with-luck(3) { change-luck(4); luck() * 2 }) },
    test("2. a story that leaves the luck alone") { assert-equal(("calm", 5), with-luck(5) { "calm" }) },
    test("2. luck can run out") {
      assert-equal(((), -2), with-luck(1) { change-luck(-2); change-luck(-1) })
    },
    test("3. each world of the quest has its own luck") {
      assert-equal([("dragon", 2), ("treasure", 2), ("home", -1)], luck-per-world(0, quest))
    },
    test("3. each world of the market counts its own coins") {
      assert-equal([(2, 2), (1, 1), (1, 1), (0, 0)], luck-per-world(0, market))
    },
    test("3. a story without branches") { assert-equal([("calm", 4)], luck-per-world(4) { "calm" }) },
    test("4. the quest's worlds share one luck") {
      assert-equal((["dragon", "treasure", "home"], 1), shared-luck(0, quest))
    },
    test("4. the market's worlds keep the coins of the worlds before") {
      assert-equal(([2, 2, 3, 3], 3), shared-luck(0, market))
    },
    test("4. a story without branches") { assert-equal((["calm"], 4), shared-luck(4) { "calm" }) },
    test("5. a lucky hero sets out and meets the dragon") {
      assert-equal(("dragon", 2), with-luck(0) { follow-luck(quest) })
    },
    test("5. an unlucky hero stays home") {
      assert-equal(("home", -2), with-luck(-1) { follow-luck(quest) })
    },
    test("5. luck decides at every branch") {
      assert-equal((2, 2), with-luck(0) { follow-luck(market) })
    },
    test("5. leaves a single world") {
      assert-equal([("dragon", 2)], all-endings { with-luck(0) { follow-luck(quest) } })
    },
  ])
