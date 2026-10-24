(defn seed-names
  "(seed-names catalog) -> array; the variety names, in catalogue order"
  [catalog]
  (error "implement me"))

(defn quick-seeds
  "(quick-seeds catalog days) -> array; the seeds ready within that many days"
  [catalog days]
  (error "implement me"))

(defn count-crop
  "(count-crop catalog crop) -> integer; how many varieties of the crop there are"
  [catalog crop]
  (error "implement me"))

(defn longest-wait
  "(longest-wait catalog) -> integer; the most days any seed takes, 0 when there are none"
  [catalog]
  (error "implement me"))

(defn all-quick?
  "(all-quick? catalog days) -> boolean; whether every seed is ready within that many days"
  [catalog days]
  (error "implement me"))
