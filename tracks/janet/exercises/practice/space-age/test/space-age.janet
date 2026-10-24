(import test :as t)
(import ../space-age :as sol)

# Ages are compared rounded to two decimal places.
(defn- round2 [x] (/ (math/round (* x 100)) 100))

(t/deftest "age on Earth"
  (t/assert-equal 31.69 (round2 (sol/age :earth 1000000000))))

(t/deftest "age on Mercury"
  (t/assert-equal 280.88 (round2 (sol/age :mercury 2134835688))))

(t/deftest "age on Venus"
  (t/assert-equal 9.78 (round2 (sol/age :venus 189839836))))

(t/deftest "age on Mars"
  (t/assert-equal 35.88 (round2 (sol/age :mars 2129871239))))

(t/deftest "age on Jupiter"
  (t/assert-equal 2.41 (round2 (sol/age :jupiter 901876382))))

(t/deftest "age on Saturn"
  (t/assert-equal 2.15 (round2 (sol/age :saturn 2000000000))))

(t/deftest "age on Uranus"
  (t/assert-equal 0.46 (round2 (sol/age :uranus 1210123456))))

(t/deftest "age on Neptune"
  (t/assert-equal 0.35 (round2 (sol/age :neptune 1821023456))))

(t/deftest "invalid planet causes error"
  (t/assert-error "not a planet" (sol/age :sun 680804807)))

(t/run)
