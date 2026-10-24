import std/num/float64
import test
import space-age

// The canonical ages are rounded to two decimal places.
fun assert-age(expected : float64, actual : float64) : exn ()
  assert-equal(expected.show-fixed(2), actual.show-fixed(2))

pub fun main()
  run([
    test("age on Earth") { assert-age(31.69, age(Earth, 1000000000)) },
    test("age on Mercury") { assert-age(280.88, age(Mercury, 2134835688)) },
    test("age on Venus") { assert-age(9.78, age(Venus, 189839836)) },
    test("age on Mars") { assert-age(35.88, age(Mars, 2129871239)) },
    test("age on Jupiter") { assert-age(2.41, age(Jupiter, 901876382)) },
    test("age on Saturn") { assert-age(2.15, age(Saturn, 2000000000)) },
    test("age on Uranus") { assert-age(0.46, age(Uranus, 1210123456)) },
    test("age on Neptune") { assert-age(0.35, age(Neptune, 1821023456)) },
  ])
