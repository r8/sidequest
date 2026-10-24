# A location is a struct {:start {:column column :row row} :end {:column column :row row}};
# rows and columns are numbered from 1.

(defn search
  "(search grid words) -> a struct mapping each word found in grid, a tuple of row strings, to its location"
  [grid words]
  (error "implement me"))
