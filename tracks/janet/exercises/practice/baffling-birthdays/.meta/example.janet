# A birthdate is a string "YYYY-MM-DD". Its birthday is the month and day alone.
# The tests accept an estimated probability within 3 percentage points, so simulate thousands
# of groups.

(defn shared-birthday?
  "(shared-birthday? birthdates) -> true when two of the birthdates fall on the same birthday"
  [birthdates]
  (def birthdays (map |(string/slice $ 5) birthdates))
  (< (length (distinct birthdays)) (length birthdays)))

(defn- leap-year? [year]
  (and (zero? (% year 4)) (or (pos? (% year 100)) (zero? (% year 400)))))

(def- non-leap-years (filter (complement leap-year?) (range 1900 2100)))

# "-MM-DD" for every day of a non-leap year; os/mktime rolls day 0..364 of January over.
(def- birthdays
  (seq [i :range [0 365]]
    (def d (os/date (os/mktime {:year 2001 :month 0 :month-day i})))
    (string/format "-%02d-%02d" (inc (d :month)) (inc (d :month-day)))))

(defn- pick [xs] (xs (math/floor (* (length xs) (math/random)))))

(defn random-birthdates
  "(random-birthdates n) -> n random birthdates in non-leap years, every birthday equally likely"
  [n]
  (seq [_ :range [0 n]] (string (pick non-leap-years) (pick birthdays))))

(defn estimated-probability-of-shared-birthday
  "(estimated-probability-of-shared-birthday group-size) -> the estimated percent chance of a shared birthday in the group"
  [group-size]
  (def trials 10000)
  (def hits (count (fn [_] (shared-birthday? (random-birthdates group-size))) (range trials)))
  (* 100 (/ hits trials)))
