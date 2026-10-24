(defn seed-names
  "(seed-names catalog) -> array; the variety names, in catalogue order"
  [catalog]
  (map |($ :name) catalog))

(defn quick-seeds
  "(quick-seeds catalog days) -> array; the seeds ready within that many days"
  [catalog days]
  (filter |(<= ($ :days) days) catalog))

(defn count-crop
  "(count-crop catalog crop) -> integer; how many varieties of the crop there are"
  [catalog crop]
  (count |(= ($ :crop) crop) catalog))

(defn longest-wait
  "(longest-wait catalog) -> integer; the most days any seed takes, 0 when there are none"
  [catalog]
  (reduce (fn [longest seed] (max longest (seed :days))) 0 catalog))

(defn all-quick?
  "(all-quick? catalog days) -> boolean; whether every seed is ready within that many days"
  [catalog days]
  (all |(<= ($ :days) days) catalog))
