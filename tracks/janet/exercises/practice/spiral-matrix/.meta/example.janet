(def- directions [[0 1] [1 0] [0 -1] [-1 0]]) # right, down, left, up

(defn spiral-matrix
  "(spiral-matrix size) -> a size x size tuple of rows holding 1 to size^2 spiralling clockwise inwards"
  [size]
  (def grid (seq [_ :range [0 size]] (array/new-filled size)))
  (defn step [[r c] d] (map + [r c] (directions (% d 4))))
  (defn free? [[r c]] (and (< -1 r size) (< -1 c size) (nil? (get-in grid [r c]))))
  (var pos [0 0])
  (var d 0)
  (for n 1 (inc (* size size))
    (put-in grid pos n)
    # Turn clockwise at the edge or at a filled cell.
    (unless (free? (step pos d)) (++ d))
    (set pos (step pos d)))
  grid)
