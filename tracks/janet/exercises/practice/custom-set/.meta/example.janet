# Sets are values: no function changes a set, add and the set operations return new ones.
# Pick any representation, as long as equal? can compare two sets.
#
# Here a set is a struct whose keys are its elements, {1 true 2 true}, so two structs with the
# same elements are already = to each other.

(defn make-set
  "(make-set elements) -> a set of the distinct items of elements"
  [elements]
  (struct ;(mapcat |[$ true] elements)))

(defn empty-set?
  "(empty-set? set) -> true when set has no elements"
  [set]
  (empty? set))

(defn contains?
  "(contains? set element) -> true when element is in set"
  [set element]
  (has-key? set element))

(defn subset?
  "(subset? set1 set2) -> true when every element of set1 is in set2"
  [set1 set2]
  (all |(contains? set2 $) (keys set1)))

(defn disjoint?
  "(disjoint? set1 set2) -> true when set1 and set2 share no element"
  [set1 set2]
  (not (some |(contains? set2 $) (keys set1))))

(defn equal?
  "(equal? set1 set2) -> true when set1 and set2 have the same elements"
  [set1 set2]
  (= set1 set2))

(defn add
  "(add set element) -> a set of the elements of set and element"
  [set element]
  (struct ;(kvs set) element true))

(defn intersection
  "(intersection set1 set2) -> a set of the elements in both set1 and set2"
  [set1 set2]
  (make-set (filter |(contains? set2 $) (keys set1))))

(defn difference
  "(difference set1 set2) -> a set of the elements of set1 that are not in set2"
  [set1 set2]
  (make-set (filter |(not (contains? set2 $)) (keys set1))))

(defn union
  "(union set1 set2) -> a set of the elements in set1, set2 or both"
  [set1 set2]
  (make-set [;(keys set1) ;(keys set2)]))
