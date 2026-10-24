(import test :as t)
(import ../baffling-birthdays :as sol)

# The random cases check properties over many generated birthdates, so a correct solution
# fails them only with negligible probability.

(defn- year [birthdate] (scan-number (string/slice birthdate 0 4)))
(defn- month [birthdate] (scan-number (string/slice birthdate 5 7)))
(defn- day [birthdate] (scan-number (string/slice birthdate 8 10)))

(defn- leap-year? [year]
  (and (zero? (% year 4)) (or (pos? (% year 100)) (zero? (% year 400)))))

(defn- assert-near
  "Passes when the number `actual` is within `tolerance` of `expected`."
  [expected actual tolerance]
  (t/assert-true (and (number? actual) (<= (math/abs (- expected actual)) tolerance))
                 (string/format "expected %q (within %q), got %q" expected tolerance actual)))

(t/deftest "one birthdate"
  (t/assert-false (sol/shared-birthday? ["2000-01-01"])))

(t/deftest "two birthdates with same year, month, and day"
  (t/assert-true (sol/shared-birthday? ["2000-01-01" "2000-01-01"])))

(t/deftest "two birthdates with same year and month, but different day"
  (t/assert-false (sol/shared-birthday? ["2012-05-09" "2012-05-17"])))

(t/deftest "two birthdates with same month and day, but different year"
  (t/assert-true (sol/shared-birthday? ["1999-10-23" "1988-10-23"])))

(t/deftest "two birthdates with same year, but different month and day"
  (t/assert-false (sol/shared-birthday? ["2007-12-19" "2007-04-27"])))

(t/deftest "two birthdates with different year, month, and day"
  (t/assert-false (sol/shared-birthday? ["1997-08-04" "1963-11-23"])))

(t/deftest "multiple birthdates without shared birthday"
  (t/assert-false (sol/shared-birthday? ["1966-07-29" "1977-02-12" "2001-12-25" "1980-11-10"])))

(t/deftest "multiple birthdates with one shared birthday"
  (t/assert-true (sol/shared-birthday? ["1966-07-29" "1977-02-12" "2001-07-29" "1980-11-10"])))

(t/deftest "multiple birthdates with more than one shared birthday"
  (t/assert-true (sol/shared-birthday? ["1966-07-29" "1977-02-12" "2001-12-25" "1980-07-29" "2019-02-12"])))

(t/deftest "generate requested number of birthdates"
  (each n [0 1 2 10 23 70 365]
    (t/assert-equal n (length (sol/random-birthdates n)))))

(t/deftest "years are not leap years"
  (each birthdate (sol/random-birthdates 1000)
    (t/assert-false (leap-year? (year birthdate)) (string birthdate " is in a leap year"))))

(t/deftest "months are random"
  (def months (distinct (map month (sol/random-birthdates 2000))))
  (t/assert-equal (range 1 13) (sort months)))

(t/deftest "days are random"
  (def days (distinct (map day (sol/random-birthdates 2000))))
  (t/assert-equal (range 1 32) (sort days)))

(t/deftest "for one person"
  (t/assert-equal 0 (sol/estimated-probability-of-shared-birthday 1)))

(t/deftest "among ten people"
  (assert-near 11.694818 (sol/estimated-probability-of-shared-birthday 10) 3))

(t/deftest "among twenty-three people"
  (assert-near 50.729723 (sol/estimated-probability-of-shared-birthday 23) 3))

(t/deftest "among seventy people"
  (assert-near 99.915958 (sol/estimated-probability-of-shared-birthday 70) 3))

(t/run)
