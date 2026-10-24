(defn sum-of-multiples
  "(sum-of-multiples factors limit) -> the sum of every number below limit that is a multiple of at least one factor"
  [factors limit]
  (sum (seq [n :range [1 limit]
             :when (some |(and (pos? $) (zero? (mod n $))) factors)]
         n)))
