# The category is a keyword: :ones :twos :threes :fours :fives :sixes
# :full-house :four-of-a-kind :little-straight :big-straight :choice :yacht

(def- faces {:ones 1 :twos 2 :threes 3 :fours 4 :fives 5 :sixes 6})

(defn score
  "(score dice category) -> the score of the five dice in category"
  [dice category]
  (def counts (frequencies dice))
  (if-let [face (faces category)]
    (* face (get counts face 0))
    (case category
      :full-house (if (deep= (sort (values counts)) @[2 3]) (sum dice) 0)
      :four-of-a-kind (if-let [face (find |(>= (counts $) 4) (keys counts))] (* 4 face) 0)
      :little-straight (if (deep= (sorted dice) @[1 2 3 4 5]) 30 0)
      :big-straight (if (deep= (sorted dice) @[2 3 4 5 6]) 30 0)
      :choice (sum dice)
      :yacht (if (= 1 (length counts)) 50 0))))
