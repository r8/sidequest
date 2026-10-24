(defn ranked-scores
  "(ranked-scores scores) -> array of the scores, highest first; scores is unchanged"
  [scores]
  (sorted scores >))

(defn by-name
  "(by-name players) -> array of the players ordered by :name"
  [players]
  (sorted-by |($ :name) players))

(defn podium
  "(podium players) -> the names of the three highest-scoring players, best first"
  [players]
  (map |($ :name) (take 3 (sorted-by |(- ($ :score)) players))))

(defn before?
  "Higher scores first; equal scores in alphabetical order of name."
  [a b]
  (if (= (a :score) (b :score))
    (< (a :name) (b :name))
    (> (a :score) (b :score))))

(defn rank!
  "(rank! board) -> board, sorted in place by :score descending, then :name"
  [board]
  (sort board before?))
