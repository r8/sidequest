(defn make-dispenser
  "(make-dispenser start) -> function; each call returns the next ticket number, from start on"
  [start]
  (error "implement me"))

(defn make-discount
  "(make-discount percent) -> function; takes a price, returns it with the discount taken off"
  [percent]
  (error "implement me"))

(defn make-limited-dispenser
  "(make-limited-dispenser start tickets) -> function; like make-dispenser, then nil once all are gone"
  [start tickets]
  (error "implement me"))

(defn make-tally
  "(make-tally) -> struct; {:sell (fn [n] …) :sold (fn [] …)} over one shared count"
  []
  (error "implement me"))
