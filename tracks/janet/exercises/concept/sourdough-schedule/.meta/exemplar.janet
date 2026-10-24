(def proof-minutes 240)

(def minutes-per-round 15)

(defn remaining-proof
  "(remaining-proof elapsed) -> integer; the minutes of proofing still needed"
  [elapsed]
  (- proof-minutes elapsed))

(defn prep-minutes
  "(prep-minutes rounds) -> integer; the minutes the stretch-and-fold rounds take"
  [rounds]
  (* rounds minutes-per-round))

(defn total-minutes
  "(total-minutes rounds elapsed) -> integer; the minutes spent on the loaf so far"
  [rounds elapsed]
  (+ (prep-minutes rounds) elapsed))
