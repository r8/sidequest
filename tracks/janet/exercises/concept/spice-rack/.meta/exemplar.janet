(def origins
  "Where the restaurant's single-grower spices come from."
  {:saffron "Iran"
   :vanilla "Madagascar"
   :paprika "Hungary"
   :cinnamon "Sri Lanka"
   :sumac "Turkey"})

(defn origin
  "(origin spice) -> string; where the spice comes from, or \"unknown\""
  [spice]
  (get origins spice "unknown"))

(defn grams-of
  "(grams-of rack spice) -> number; the grams of the spice in the rack, 0 when there is none"
  [rack spice]
  (get rack spice 0))

(defn restock
  "(restock rack spice grams) -> table; the rack with the grams added to the spice's jar"
  [rack spice grams]
  (put rack spice (+ (grams-of rack spice) grams)))

(defn use-spice
  "(use-spice rack spice grams) -> table; the rack with the grams taken out, empty jars removed"
  [rack spice grams]
  (def left (- (grams-of rack spice) grams))
  (put rack spice (if (> left 0) left nil)))

(defn low-stock
  "(low-stock rack limit) -> table; a new table of the spices with fewer grams than limit"
  [rack limit]
  (def low @{})
  (eachp [spice grams] rack
    (when (< grams limit)
      (put low spice grams)))
  low)
