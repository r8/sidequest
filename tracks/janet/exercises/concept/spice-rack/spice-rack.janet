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
  (error "implement me"))

(defn grams-of
  "(grams-of rack spice) -> number; the grams of the spice in the rack, 0 when there is none"
  [rack spice]
  (error "implement me"))

(defn restock
  "(restock rack spice grams) -> table; the rack with the grams added to the spice's jar"
  [rack spice grams]
  (error "implement me"))

(defn use-spice
  "(use-spice rack spice grams) -> table; the rack with the grams taken out, empty jars removed"
  [rack spice grams]
  (error "implement me"))

(defn low-stock
  "(low-stock rack limit) -> table; a new table of the spices with fewer grams than limit"
  [rack limit]
  (error "implement me"))
