(defn- within?
  "True when `small` appears as a contiguous run in `big`."
  [small big]
  (def n (length small))
  (some |(deep= (tuple/slice small) (tuple/slice big $ (+ $ n)))
        (range (- (length big) n -1))))

(defn sublist
  "(sublist list-one list-two) -> :equal, :sublist, :superlist or :unequal"
  [list-one list-two]
  (cond
    (deep= (tuple/slice list-one) (tuple/slice list-two)) :equal
    (within? list-one list-two) :sublist
    (within? list-two list-one) :superlist
    :unequal))
