(defn make-dispenser
  "(make-dispenser start) -> function; each call returns the next ticket number, from start on"
  [start]
  (var next start)
  (fn []
    (def ticket next)
    (++ next)
    ticket))

(defn make-discount
  "(make-discount percent) -> function; takes a price, returns it with the discount taken off"
  [percent]
  (fn [price] (* price (/ (- 100 percent) 100))))

(defn make-limited-dispenser
  "(make-limited-dispenser start tickets) -> function; like make-dispenser, then nil once all are gone"
  [start tickets]
  (def dispense (make-dispenser start))
  (var left tickets)
  (fn []
    (when (> left 0)
      (-- left)
      (dispense))))

(defn make-tally
  "(make-tally) -> struct; {:sell (fn [n] …) :sold (fn [] …)} over one shared count"
  []
  (var sold 0)
  {:sell (fn [n] (+= sold n))
   :sold (fn [] sold)})
