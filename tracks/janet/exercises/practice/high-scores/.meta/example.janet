(defn make-high-scores
  "(make-high-scores scores) -> a high score list holding scores, oldest first"
  [scores]
  @{:scores (array ;scores)})

(defn scores
  "(scores high-scores) -> all the scores, in the order they were added"
  [high-scores]
  (high-scores :scores))

(defn latest
  "(latest high-scores) -> the most recently added score"
  [high-scores]
  (last (high-scores :scores)))

(defn personal-best
  "(personal-best high-scores) -> the highest score"
  [high-scores]
  (max ;(high-scores :scores)))

(defn personal-top-three
  "(personal-top-three high-scores) -> up to three highest scores, highest first"
  [high-scores]
  # sorted, not sort: sorting in place would reorder the stored scores
  (take 3 (sorted (high-scores :scores) >)))
