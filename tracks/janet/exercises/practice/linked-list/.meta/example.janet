# A list is a mutable table made by make-list; the other functions change or read it.
# Build it from linked nodes, each pointing to the one before and after it, rather than an array.

(defn make-list
  "(make-list) -> a new empty list"
  []
  @{:head nil :tail nil :size 0})

(defn- link
  "Puts a new node holding value between the nodes before and after (either may be nil)."
  [list value before after]
  (def node @{:value value :prev before :next after})
  (if before (put before :next node) (put list :head node))
  (if after (put after :prev node) (put list :tail node))
  (update list :size inc))

(defn- unlink
  "Takes node out of list and returns its value."
  [list node]
  (def {:prev before :next after} node)
  (if before (put before :next after) (put list :head after))
  (if after (put after :prev before) (put list :tail before))
  (update list :size dec)
  (node :value))

(defn push
  "(push list value) -> list, with value added at the end"
  [list value]
  (link list value (list :tail) nil))

(defn pop
  "(pop list) -> the value at the end, removed from list"
  [list]
  (unlink list (list :tail)))

(defn shift
  "(shift list) -> the value at the start, removed from list"
  [list]
  (unlink list (list :head)))

(defn unshift
  "(unshift list value) -> list, with value added at the start"
  [list value]
  (link list value nil (list :head)))

(defn size
  "(size list) -> the number of values in list"
  [list]
  (list :size))

(defn delete
  "(delete list value) -> list, without the first node holding value (unchanged if there is none)"
  [list value]
  (var node (list :head))
  (while (and node (not= value (node :value)))
    (set node (node :next)))
  (when node (unlink list node))
  list)
