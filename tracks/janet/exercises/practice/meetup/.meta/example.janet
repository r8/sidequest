# week is one of :first :second :third :fourth :last :teenth; weekday is one of :monday
# :tuesday :wednesday :thursday :friday :saturday :sunday. Months count from 1 (January).

# os/date numbers weekdays from Sunday = 0.
(def- weekdays [:sunday :monday :tuesday :wednesday :thursday :friday :saturday])

(defn- date
  "The UTC date struct for a day of the month; os/mktime counts months and days from 0
  and rolls an out-of-range day over into the next or previous month."
  [year month day]
  (os/date (os/mktime {:year year :month (dec month) :month-day (dec day)})))

(defn meetup
  "(meetup year month week weekday) -> the date of the meetup as \"YYYY-MM-DD\""
  [year month week weekday]
  # Every week descriptor names seven consecutive days; find where they start.
  (def start (case week
               :first 1 :second 8 :third 15 :fourth 22 :teenth 13
               :last (- (inc ((date year (inc month) 0) :month-day)) 6)))
  (def offset (% (+ 7 (- (index-of weekday weekdays) ((date year month start) :week-day))) 7))
  (string/format "%04d-%02d-%02d" year month (+ start offset)))
