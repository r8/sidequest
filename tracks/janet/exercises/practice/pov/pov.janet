# A tree is a struct {:label label :children [tree ...]}; a leaf may leave out :children.

(defn from-pov
  "(from-pov tree from) -> the same tree re-rooted at the node labeled from"
  [tree from]
  (error "implement me"))

(defn path-to
  "(path-to tree from to) -> an array of the labels on the path from one node to another"
  [tree from to]
  (error "implement me"))
