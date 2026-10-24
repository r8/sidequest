# A domino is a tuple of its two numbers, e.g. [1 2].

(defn- closes?
  "True when the stones extend a chain ending in `end` back round to `start`."
  [start end stones]
  (if (empty? stones)
    (= start end)
    (truthy?
      (some (fn [i]
              (def [a b] (stones i))
              (def rest (array/remove (array/slice stones) i))
              (or (and (= a end) (closes? start b rest))
                  (and (= b end) (closes? start a rest))))
            (range (length stones))))))

(defn can-chain?
  "(can-chain? dominoes) -> true when all the dominoes form one closed chain"
  [dominoes]
  (or (empty? dominoes)
      (let [[[a b] & rest] dominoes]
        (closes? a b rest))))
