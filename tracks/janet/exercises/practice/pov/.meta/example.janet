# A tree is a struct {:label label :children [tree ...]}; a leaf may leave out :children.

(defn- path-down
  "The nodes from the root of tree down to the node labeled target, or nil."
  [tree target]
  (if (= target (tree :label))
    @[tree]
    (when-let [path (some |(path-down $ target) (get tree :children []))]
      (array/insert path 0 tree))))

(defn- node [name children]
  (if (empty? children) {:label name} {:label name :children children}))

(defn from-pov
  "(from-pov tree from) -> the same tree re-rooted at the node labeled from"
  [tree from]
  (def path (path-down tree from))
  (unless path (error "Tree could not be reoriented"))
  # Walk down the path: each node drops the child it leads to and adopts the re-rooted part above.
  (var above nil)
  (eachp [i {:label here :children children}] path
    (def below (get-in path [(+ i 1) :label]))
    (def kept (filter |(not= below ($ :label)) (or children [])))
    (set above (node here (if above [;kept above] kept))))
  above)

(defn path-to
  "(path-to tree from to) -> an array of the labels on the path from one node to another"
  [tree from to]
  (def path (and (path-down tree from) (path-down (from-pov tree from) to)))
  (unless path (error "No path found"))
  (map |($ :label) path))
