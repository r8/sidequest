import test
import bike-rental

pub fun main()
  run([
    test("1. a new bike is in the shed and unridden") {
      assert-equal(Bike(7, "Gazelle", "", 0), new-bike(7, "Gazelle"))
    },
    test("1. another new bike") { assert-equal(Bike(12, "Batavus", "", 0), new-bike(12, "Batavus")) },
    test("2. a new bike is available") { assert-true(new-bike(1, "Sparta").is-available) },
    test("2. a bike with a rider is not available") { assert-false(Bike(1, "Sparta", "Ann", 30).is-available) },
    test("2. a ridden bike back in the shed is available") { assert-true(Bike(2, "Sparta", "", 300).is-available) },
    test("3. renting sets the rider") { assert-equal("Tomás", new-bike(7, "Gazelle").rent("Tomás").rider) },
    test("3. renting keeps everything else") {
      assert-equal(Bike(4, "Cortina", "Ines", 80), Bike(4, "Cortina", "", 80).rent("Ines"))
    },
    test("3. a rented bike is not available") { assert-false(new-bike(5, "Gazelle").rent("Li").is-available) },
    test("4. a returned bike has no rider") {
      assert-true(new-bike(7, "Gazelle").rent("Tomás").return-bike(12).is-available)
    },
    test("4. the ride is added to the total") {
      assert-equal(Bike(4, "Cortina", "", 95), Bike(4, "Cortina", "Ines", 80).return-bike(15))
    },
    test("4. several rides add up") {
      assert-equal(27, new-bike(9, "Union").rent("A").return-bike(12).rent("B").return-bike(15).km)
    },
    test("5. the tag of a bike in the shed") { assert-equal("#7 Gazelle, 120 km", Bike(7, "Gazelle", "", 120).tag) },
    test("5. the tag of a new bike") { assert-equal("#12 Batavus, 0 km", new-bike(12, "Batavus").tag) },
    test("5. the tag of a bike that is out") {
      assert-equal("#3 Batavus, 45 km, out with Ines", Bike(3, "Batavus", "Ines", 45).tag)
    },
  ])
