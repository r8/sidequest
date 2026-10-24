# A matrix is a tuple of rows; each cell is 1 (alive) or 0 (dead).

(defn tick
  "(tick matrix) -> the matrix one generation later"
  [matrix]
  (defn neighbours [r c]
    (sum (seq [dr :in [-1 0 1] dc :in [-1 0 1] :unless (= 0 dr dc)]
           (get-in matrix [(+ r dr) (+ c dc)] 0))))
  (seq [[r row] :pairs matrix]
    (seq [[c cell] :pairs row]
      (case (neighbours r c)
        3 1
        2 cell
        0))))
