(defn- letters [word] (sorted (string/bytes word)))

(defn find-anagrams
  "(find-anagrams subject candidates) -> the candidates that are anagrams of subject, in order"
  [subject candidates]
  (def lower (string/ascii-lower subject))
  (def key (letters lower))
  (filter (fn [candidate]
            (def c (string/ascii-lower candidate))
            (and (not= c lower) (deep= key (letters c))))
          candidates))
