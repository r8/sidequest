# Sets are values: no function changes a set, add and the set operations return new ones.
# Pick any representation, as long as equal? can compare two sets.

(defn make-set
  "(make-set elements) -> a set of the distinct items of elements"
  [elements]
  (error "implement me"))

(defn empty-set?
  "(empty-set? set) -> true when set has no elements"
  [set]
  (error "implement me"))

(defn contains?
  "(contains? set element) -> true when element is in set"
  [set element]
  (error "implement me"))

(defn subset?
  "(subset? set1 set2) -> true when every element of set1 is in set2"
  [set1 set2]
  (error "implement me"))

(defn disjoint?
  "(disjoint? set1 set2) -> true when set1 and set2 share no element"
  [set1 set2]
  (error "implement me"))

(defn equal?
  "(equal? set1 set2) -> true when set1 and set2 have the same elements"
  [set1 set2]
  (error "implement me"))

(defn add
  "(add set element) -> a set of the elements of set and element"
  [set element]
  (error "implement me"))

(defn intersection
  "(intersection set1 set2) -> a set of the elements in both set1 and set2"
  [set1 set2]
  (error "implement me"))

(defn difference
  "(difference set1 set2) -> a set of the elements of set1 that are not in set2"
  [set1 set2]
  (error "implement me"))

(defn union
  "(union set1 set2) -> a set of the elements in set1, set2 or both"
  [set1 set2]
  (error "implement me"))
