import test
import parcel-post

pub fun main()
  run([
    test("1. a light parcel") { assert-equal(7, postage(1)) },
    test("1. a heavier parcel") { assert-equal(25, postage(10)) },
    test("1. a light parcel by express") { assert-equal(14, postage(1, express = True)) },
    test("1. a heavier parcel by express") { assert-equal(50, postage(10, True)) },
    test("1. a standard parcel, said explicitly") { assert-equal(11, postage(3, express = False)) },
    test("2. a small box") { assert-false(is-oversize(30, 20, 10)) },
    test("2. exactly at the limit") { assert-false(is-oversize(100, 50, 50)) },
    test("2. just over the limit") { assert-true(is-oversize(101, 50, 50)) },
    test("2. a long, thin parcel") { assert-true(is-oversize(290, 3, 3)) },
    test("3. a small standard parcel") { assert-equal(9, parcel-cost(2, 30, 20, 10)) },
    test("3. a small express parcel") { assert-equal(18, parcel-cost(2, 30, 20, 10, express = True)) },
    test("3. an oversized standard parcel") { assert-equal(30, parcel-cost(5, 150, 50, 50)) },
    test("3. an oversized express parcel") { assert-equal(45, parcel-cost(5, 150, 50, 50, express = True)) },
    test("4. overpaid") { assert-equal(3, refund(10, 1)) },
    test("4. paid exactly") { assert-equal(0, refund(11, 3)) },
    test("4. underpaid gives no refund") { assert-equal(0, refund(5, 3)) },
  ])
