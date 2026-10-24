# A tree is a node struct {:data value :left subtree :right subtree}; an empty subtree is nil.
# Values no greater than a node's data go to its left, larger values to its right.

(defn- insert [tree value]
  (if-let [{:data data :left left :right right} tree]
    (if (<= value data)
      {:data data :left (insert left value) :right right}
      {:data data :left left :right (insert right value)})
    {:data value :left nil :right nil}))

(defn make-tree
  "(make-tree values) -> the tree made by inserting values, in order, into an empty tree"
  [values]
  (reduce insert nil values))

(defn sorted-data
  "(sorted-data tree) -> an array of the tree's values in sorted order"
  [tree]
  (if tree
    @[;(sorted-data (tree :left)) (tree :data) ;(sorted-data (tree :right))]
    @[]))
