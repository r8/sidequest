# A location is a struct {:start {:column column :row row} :end {:column column :row row}};
# rows and columns are numbered from 1.

(defn- locate [grid word]
  (def last-step (dec (length word)))
  (defn spells? [r c dr dc]
    (all |(= (word $) (get-in grid [(+ r (* $ dr)) (+ c (* $ dc))]))
         (range (length word))))
  (first
    (seq [[r row] :pairs grid
          c :range [0 (length row)]
          dr :in [-1 0 1]
          dc :in [-1 0 1]
          :unless (= 0 dr dc)
          :when (spells? r c dr dc)]
      {:start {:column (inc c) :row (inc r)}
       :end {:column (+ c 1 (* last-step dc)) :row (+ r 1 (* last-step dr))}})))

(defn search
  "(search grid words) -> a struct mapping each word found in grid, a tuple of row strings, to its location"
  [grid words]
  (struct ;(mapcat |[$ (locate grid $)] words)))
