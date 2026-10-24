# A tree is a node struct {:data value :left subtree :right subtree}; an empty subtree is nil.
# Values no greater than a node's data go to its left, larger values to its right.

(defn make-tree
  "(make-tree values) -> the tree made by inserting values, in order, into an empty tree"
  [values]
  (error "implement me"))

(defn sorted-data
  "(sorted-data tree) -> an array of the tree's values in sorted order"
  [tree]
  (error "implement me"))
