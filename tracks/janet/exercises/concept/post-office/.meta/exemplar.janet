(defn post
  "(post box letters) -> box; each letter given to the box in order"
  [box letters]
  (each letter letters
    (ev/give box letter))
  box)

(defn collect
  "(collect box n) -> array of the next n letters taken from the box"
  [box n]
  (def letters @[])
  (for i 0 n
    (array/push letters (ev/take box)))
  letters)

(defn start-stamper
  "(start-stamper in out) -> task stamping letters from in onto out until in is closed"
  [in out]
  (ev/go
    (fn []
      (var letter (ev/take in))
      (while letter
        (ev/give out (string letter " [stamped]"))
        (set letter (ev/take in))))))

(defn run-office
  "(run-office letters) -> array of the letters stamped, in order"
  [letters]
  (def in (ev/chan))
  (def out (ev/chan (length letters)))
  (start-stamper in out)
  (post in letters)
  (def stamped (collect out (length letters)))
  (ev/chan-close in)
  (ev/sleep 0)
  stamped)

(defn deliver-both
  "(deliver-both a b) -> @[(a) (b)], with a and b run at the same time"
  [a b]
  (ev/gather (a) (b)))
