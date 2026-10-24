(defn find-fewest-coins
  "(find-fewest-coins coins target) -> the fewest coins that add up to target, in ascending order"
  [coins target]
  (when (neg? target) (error "target can't be negative"))
  # best[t] is a shortest list of coins adding up to t, or nil when t can't be made
  (def best @[[]])
  (loop [t :range-to [1 target]]
    (array/push best
                (extreme |(< (length $0) (length $1))
                         (seq [coin :in coins
                               :when (<= coin t)
                               :let [rest (best (- t coin))]
                               :when rest]
                           [;rest coin]))))
  (sorted (or (best target) (error "can't make target with given coins"))))
