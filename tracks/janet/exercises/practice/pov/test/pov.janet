(import test :as t)
(import ../pov :as sol)

# Children may come back in any order: compare trees with every child list sorted by label.
(defn- normalize [tree]
  (def children (sort-by |($ :label) (map normalize (get tree :children []))))
  (if (empty? children) {:label (tree :label)} {:label (tree :label) :children children}))

(t/deftest "Results in the same tree if the input tree is a singleton"
  (t/assert-equal (normalize {:label "x"})
    (normalize (sol/from-pov {:label "x"} "x"))))

(t/deftest "Can reroot a tree with a parent and one sibling"
  (t/assert-equal (normalize {:label "x" :children [{:label "parent" :children [{:label "sibling"}]}]})
    (normalize (sol/from-pov {:label "parent" :children [{:label "x"} {:label "sibling"}]} "x"))))

(t/deftest "Can reroot a tree with a parent and many siblings"
  (t/assert-equal (normalize {:label "x" :children [{:label "parent" :children [{:label "a"} {:label "b"} {:label "c"}]}]})
    (normalize (sol/from-pov {:label "parent" :children [{:label "a"} {:label "x"} {:label "b"} {:label "c"}]} "x"))))

(t/deftest "Can reroot a tree with new root deeply nested in tree"
  (t/assert-equal (normalize {:label "x" :children [{:label "level-3" :children [{:label "level-2" :children [{:label "level-1" :children [{:label "level-0"}]}]}]}]})
    (normalize (sol/from-pov {:label "level-0" :children [{:label "level-1" :children [{:label "level-2" :children [{:label "level-3" :children [{:label "x"}]}]}]}]} "x"))))

(t/deftest "Moves children of the new root to same level as former parent"
  (t/assert-equal (normalize {:label "x" :children [{:label "kid-0"} {:label "kid-1"} {:label "parent"}]})
    (normalize (sol/from-pov {:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]}]} "x"))))

(t/deftest "Can reroot a complex tree with cousins"
  (t/assert-equal (normalize {:label "x" :children [{:label "kid-1"} {:label "kid-0"} {:label "parent" :children [{:label "sibling-0"} {:label "sibling-1"} {:label "grandparent" :children [{:label "uncle" :children [{:label "cousin-0"} {:label "cousin-1"}]}]}]}]})
    (normalize (sol/from-pov {:label "grandparent" :children [{:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]} {:label "sibling-0"} {:label "sibling-1"}]} {:label "uncle" :children [{:label "cousin-0"} {:label "cousin-1"}]}]} "x"))))

(t/deftest "Errors if target does not exist in a singleton tree"
  (t/assert-error "Tree could not be reoriented" (sol/from-pov {:label "x"} "nonexistent")))

(t/deftest "Errors if target does not exist in a large tree"
  (t/assert-error "Tree could not be reoriented" (sol/from-pov {:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]} {:label "sibling-0"} {:label "sibling-1"}]} "nonexistent")))

(t/deftest "Can find path to parent"
  (t/assert-equal ["x" "parent"]
    (sol/path-to {:label "parent" :children [{:label "x"} {:label "sibling"}]} "x" "parent")))

(t/deftest "Can find path to sibling"
  (t/assert-equal ["x" "parent" "b"]
    (sol/path-to {:label "parent" :children [{:label "a"} {:label "x"} {:label "b"} {:label "c"}]} "x" "b")))

(t/deftest "Can find path to cousin"
  (t/assert-equal ["x" "parent" "grandparent" "uncle" "cousin-1"]
    (sol/path-to {:label "grandparent" :children [{:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]} {:label "sibling-0"} {:label "sibling-1"}]} {:label "uncle" :children [{:label "cousin-0"} {:label "cousin-1"}]}]} "x" "cousin-1")))

(t/deftest "Can find path not involving root"
  (t/assert-equal ["x" "parent" "sibling-1"]
    (sol/path-to {:label "grandparent" :children [{:label "parent" :children [{:label "x"} {:label "sibling-0"} {:label "sibling-1"}]}]} "x" "sibling-1")))

(t/deftest "Can find path from nodes other than x"
  (t/assert-equal ["a" "parent" "c"]
    (sol/path-to {:label "parent" :children [{:label "a"} {:label "x"} {:label "b"} {:label "c"}]} "a" "c")))

(t/deftest "Errors if destination does not exist"
  (t/assert-error "No path found" (sol/path-to {:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]} {:label "sibling-0"} {:label "sibling-1"}]} "x" "nonexistent")))

(t/deftest "Errors if source does not exist"
  (t/assert-error "No path found" (sol/path-to {:label "parent" :children [{:label "x" :children [{:label "kid-0"} {:label "kid-1"}]} {:label "sibling-0"} {:label "sibling-1"}]} "nonexistent" "x")))

(t/run)
