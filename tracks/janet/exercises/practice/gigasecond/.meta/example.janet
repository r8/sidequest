# A moment is a UTC timestamp string: "2015-01-24T22:00:00", or just a date, "2011-04-25",
# meaning midnight.

(def- moment-peg
  (peg/compile
    ~{:num (/ ':d+ ,scan-number)
      :main (* :num "-" :num "-" :num (? (* "T" :num ":" :num ":" :num)) -1)}))

(defn add
  "(add moment) -> the moment one gigasecond later, as \"YYYY-MM-DDThh:mm:ss\""
  [moment]
  (def [year month day hours minutes seconds] (peg/match moment-peg moment))
  # os/mktime and os/date work in UTC; months and days count from 0 there.
  (def t (os/mktime {:year year :month (dec month) :month-day (dec day)
                     :hours (or hours 0) :minutes (or minutes 0) :seconds (or seconds 0)}))
  (def d (os/date (+ t 1e9)))
  (string/format "%04d-%02d-%02dT%02d:%02d:%02d"
                 (d :year) (inc (d :month)) (inc (d :month-day)) (d :hours) (d :minutes) (d :seconds)))
