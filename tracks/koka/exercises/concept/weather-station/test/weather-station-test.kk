import test
import weather-station

// A fixed set of readings, installed by the tests of tasks 1 to 3.
fun hills(action : () -> <sensor|e> a) : e a
  with fun reading(station)
    if station == "roof" then 21
    elif station == "cellar" then 15
    elif station == "summit" then -4
    else 10
  action()

pub fun main()
  run([
    test("1. difference of a warmer and a colder station") {
      with hills
      assert-equal(6, difference("roof", "cellar"))
    },
    test("1. difference of a colder and a warmer station") {
      with hills
      assert-equal(-25, difference("summit", "roof"))
    },
    test("1. difference of a station with itself") {
      with hills
      assert-equal(0, difference("cellar", "cellar"))
    },
    test("2. average of two stations") {
      with hills
      assert-equal(18, average(["roof", "cellar"]))
    },
    test("2. average is rounded down") {
      with hills
      assert-equal(10, average(["roof", "cellar", "summit"]))
    },
    test("2. average of one station") {
      with hills
      assert-equal(-4, average(["summit"]))
    },
    test("2. average without stations") {
      with hills
      assert-equal(0, average([]))
    },
    test("3. report in Celsius") {
      with hills
      with val units = "C"
      assert-equal("roof: 21C", report("roof"))
    },
    test("3. report a reading below zero") {
      with hills
      with val units = " degrees"
      assert-equal("summit: -4 degrees", report("summit"))
    },
    test("4. readings from a table") {
      assert-equal(6, with-readings([("roof", 21), ("cellar", 15)]) { difference("roof", "cellar") })
    },
    test("4. a station missing from the table reads 0") {
      assert-equal(0, with-readings([("roof", 21)]) { reading("lighthouse") })
    },
    test("4. the first entry for a station counts") {
      assert-equal(3, with-readings([("roof", 3), ("roof", 30)]) { reading("roof") })
    },
    test("4. a report from a table") {
      with val units = "F"
      assert-equal("cellar: 59F", with-readings([("cellar", 59)]) { report("cellar") })
    },
    test("5. an offset raises the readings") {
      assert-equal(23, with-readings([("roof", 21)]) { with-offset(2) { reading("roof") } })
    },
    test("5. a negative offset lowers them") {
      assert-equal(-6, with-readings([("summit", -4)]) { with-offset(-2) { reading("summit") } })
    },
    test("5. offsets add up") {
      assert-equal(26, with-readings([("roof", 21)]) { with-offset(2) { with-offset(3) { reading("roof") } } })
    },
    test("5. an offset leaves differences alone") {
      assert-equal(6, with-readings([("roof", 21), ("cellar", 15)]) { with-offset(5) { difference("roof", "cellar") } })
    },
  ])
