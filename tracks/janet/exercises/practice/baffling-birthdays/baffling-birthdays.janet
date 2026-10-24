# A birthdate is a string "YYYY-MM-DD". Its birthday is the month and day alone.
# The tests accept an estimated probability within 3 percentage points, so simulate thousands
# of groups.

(defn shared-birthday?
  "(shared-birthday? birthdates) -> true when two of the birthdates fall on the same birthday"
  [birthdates]
  (error "implement me"))

(defn random-birthdates
  "(random-birthdates n) -> n random birthdates in non-leap years, every birthday equally likely"
  [n]
  (error "implement me"))

(defn estimated-probability-of-shared-birthday
  "(estimated-probability-of-shared-birthday group-size) -> the estimated percent chance of a shared birthday in the group"
  [group-size]
  (error "implement me"))
