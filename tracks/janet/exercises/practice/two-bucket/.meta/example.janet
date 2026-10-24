# Buckets are named :one and :two.

(defn- moves-from
  "Every state one action away from [a b]: fill, empty or pour either bucket."
  [[a b] [size-a size-b]]
  (def a->b (min a (- size-b b)))
  (def b->a (min b (- size-a a)))
  [[size-a b] [a size-b] [0 b] [a 0]
   [(- a a->b) (+ b a->b)] [(+ a b->a) (- b b->a)]])

(defn measure
  "(measure size-one size-two goal start) -> {:moves n :goal-bucket bucket :other-bucket liters}"
  [size-one size-two goal start]
  (def sizes [size-one size-two])
  # The first fill is move 1; the start bucket may never be empty while the other is full.
  (def [initial forbidden]
    (if (= start :one)
      [[size-one 0] [0 size-two]]
      [[0 size-two] [size-one 0]]))
  (def seen @{initial true forbidden true})
  (var frontier [initial])
  (var moves 1)
  (var found nil)
  # Breadth-first search, one move per level.
  (while (and (nil? found) (not (empty? frontier)))
    (set found (find (fn [[a b]] (or (= a goal) (= b goal))) frontier))
    (unless found
      (set frontier (seq [state :in frontier
                          after :in (moves-from state sizes)
                          :unless (seen after)]
                      (put seen after true)
                      after))
      (++ moves)))
  (unless found (error "impossible"))
  (def [a b] found)
  (if (= a goal)
    {:moves moves :goal-bucket :one :other-bucket b}
    {:moves moves :goal-bucket :two :other-bucket a}))
