# Everything is built on foldl, the one loop written by hand. Each definition shadows the core
# function of the same name for the rest of this file, so foldr's `reverse` is the one below.

(defn foldl
  "(foldl f init items) -> (f (f (f init item1) item2) ...), folding from the left"
  [f init items]
  (var acc init)
  (each item items
    (set acc (f acc item)))
  acc)

(defn append
  "(append list1 list2) -> a new array with the items of list1 followed by those of list2"
  [list1 list2]
  (foldl array/push (foldl array/push @[] list1) list2))

(defn concat
  "(concat lists) -> a new array with the items of every list in lists, in order (one level only)"
  [lists]
  (foldl |(foldl array/push $0 $1) @[] lists))

(defn filter
  "(filter pred items) -> a new array with the items for which pred is truthy"
  [pred items]
  (foldl (fn [acc item] (if (pred item) (array/push acc item) acc)) @[] items))

(defn length
  "(length items) -> the number of items"
  [items]
  (foldl (fn [n _] (+ n 1)) 0 items))

(defn map
  "(map f items) -> a new array with f applied to each item"
  [f items]
  (foldl (fn [acc item] (array/push acc (f item))) @[] items))

(defn reverse
  "(reverse items) -> a new array with the items in reverse order"
  [items]
  (foldl (fn [acc item] (array/insert acc 0 item)) @[] items))

(defn foldr
  "(foldr f init items) -> (f (f (f init itemN) itemN-1) ...), folding from the right"
  [f init items]
  (foldl f init (reverse items)))
