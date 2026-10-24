# Each item is a struct such as {:weight 5 :value 10}.

(defn maximum-value
  "(maximum-value maximum-weight items) -> the largest total value of items that fit within maximum-weight"
  [maximum-weight items]
  # best[w] is the most value that fits in weight w using the items seen so far;
  # going down from the top uses each item at most once
  (def best (array/new-filled (inc maximum-weight) 0))
  (each {:weight weight :value value} items
    (loop [w :down-to [maximum-weight weight]]
      (put best w (max (best w) (+ value (best (- w weight)))))))
  (last best))
