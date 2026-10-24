import test
import garden-sprinklers

pub fun main()
  run([
    test("1. twice runs the action two times") {
      var clicks := 0
      twice { clicks := clicks + 1 }
      assert-equal(2, clicks)
    },
    test("1. twice nested runs the action four times") {
      var clicks := 0
      twice { twice { clicks := clicks + 1 } }
      assert-equal(4, clicks)
    },
    test("1. twice runs the action in order") {
      var log := ""
      var n := 0
      twice
        n := n + 1
        log := log ++ n.show
      assert-equal("12", log)
    },
    test("2. each-bed visits every bed in order") {
      var visited := []
      each-bed(["carrots", "kale", "beans"]) fn(bed) visited := Cons(bed, visited)
      assert-equal(["carrots", "kale", "beans"], visited.reverse)
    },
    test("2. each-bed skips the beds that are switched off") {
      var visited := []
      each-bed(["carrots", "#strawberries", "kale", "#peas"]) fn(bed) visited := Cons(bed, visited)
      assert-equal(["carrots", "kale"], visited.reverse)
    },
    test("2. each-bed on an empty garden does nothing") {
      var visited := []
      each-bed([]) fn(bed) visited := Cons(bed, visited)
      assert-equal([], visited)
    },
    test("2. each-bed on a garden switched off does nothing") {
      var visited := []
      each-bed(["#strawberries", "#peas"]) fn(bed) visited := Cons(bed, visited)
      assert-equal([], visited)
    },
    test("3. one round") {
      assert-equal(["round 1: carrots", "round 1: kale"], round-plan(["carrots", "kale"], 1))
    },
    test("3. two rounds skip the beds that are switched off") {
      assert-equal(
        ["round 1: carrots", "round 1: kale", "round 2: carrots", "round 2: kale"],
        round-plan(["carrots", "#strawberries", "kale"], 2)
      )
    },
    test("3. three rounds of one bed") {
      assert-equal(["round 1: beans", "round 2: beans", "round 3: beans"], round-plan(["beans"], 3))
    },
    test("3. no rounds") { assert-equal([], round-plan(["carrots", "kale"], 0)) },
    test("4. double soak of two beds") {
      assert-equal(["carrots", "carrots", "kale", "kale"], double-soak(["carrots", "kale"]))
    },
    test("4. double soak skips the beds that are switched off") {
      assert-equal(["carrots", "carrots", "kale", "kale"], double-soak(["#peas", "carrots", "#strawberries", "kale"]))
    },
    test("4. double soak of an empty garden") { assert-equal([], double-soak([])) },
  ])
