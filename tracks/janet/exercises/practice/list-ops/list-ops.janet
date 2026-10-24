# Implement these without the core functions they are named after (or reduce, array/concat, ...).
# Like Janet's own map, filter and reduce, the function comes first and the list last.

(defn append
  "(append list1 list2) -> a new array with the items of list1 followed by those of list2"
  [list1 list2]
  (error "implement me"))

(defn concat
  "(concat lists) -> a new array with the items of every list in lists, in order (one level only)"
  [lists]
  (error "implement me"))

(defn filter
  "(filter pred items) -> a new array with the items for which pred is truthy"
  [pred items]
  (error "implement me"))

(defn length
  "(length items) -> the number of items"
  [items]
  (error "implement me"))

(defn map
  "(map f items) -> a new array with f applied to each item"
  [f items]
  (error "implement me"))

(defn foldl
  "(foldl f init items) -> (f (f (f init item1) item2) ...), folding from the left"
  [f init items]
  (error "implement me"))

(defn foldr
  "(foldr f init items) -> (f (f (f init itemN) itemN-1) ...), folding from the right"
  [f init items]
  (error "implement me"))

(defn reverse
  "(reverse items) -> a new array with the items in reverse order"
  [items]
  (error "implement me"))
