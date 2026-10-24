(defn total
  "(total counts) -> integer; the fireflies counted over the season"
  [counts]
  (var sum 0)
  (each count counts
    (+= sum count))
  sum)

(defn busy-nights
  "(busy-nights counts threshold) -> integer; the nights with at least threshold fireflies"
  [counts threshold]
  (var nights 0)
  (each count counts
    (when (>= count threshold)
      (++ nights)))
  nights)

(defn first-quiet-night
  "(first-quiet-night counts) -> integer or nil; the index of the first night without fireflies"
  [counts]
  (var night nil)
  (for i 0 (length counts)
    (when (= 0 (get counts i))
      (set night i)
      (break)))
  night)

(defn correct-counts!
  "(correct-counts! counts) -> array; the counts with the first night of every week halved"
  [counts]
  (var i 0)
  (while (< i (length counts))
    (put counts i (/ (get counts i) 2))
    (+= i 7))
  counts)

(defn nights-to-reach
  "(nights-to-reach counts goal) -> integer or nil; the nights it took for the total to reach goal"
  [counts goal]
  (var sum 0)
  (var nights 0)
  (while (and (< sum goal) (< nights (length counts)))
    (+= sum (get counts nights))
    (++ nights))
  (when (>= sum goal)
    nights))
