# Each letter gets a weight: the sum of the place values where it appears, negated on the right
# of "==". A solution is an assignment of distinct digits whose weighted sum is zero.
#
# Letters are tried heaviest first. The letters still unassigned can only add between
# 9 * (their negative weights) and 9 * (their positive weights), so a partial sum that this
# cannot bring back to zero is abandoned at once.

(defn solve
  "(solve puzzle) -> a struct from each letter (a one-character string) to its digit, or nil when there is no solution"
  [puzzle]
  (def weight @{})
  (def leading @{})
  (each [side sign] (map tuple (string/split "==" puzzle) [1 -1])
    (each word (map string/trim (string/split "+" side))
      (when (> (length word) 1) (put leading (first word) true))
      (eachp [column letter] (reverse word)
        (put weight letter (+ (get weight letter 0) (* sign (math/pow 10 column)))))))
  (def letters (sort-by |(- (math/abs (weight $))) (keys weight)))
  (def n (length letters))
  # The lowest and highest sum that letters i and later can still add.
  (def low (array/new-filled (+ n 1) 0))
  (def high (array/new-filled (+ n 1) 0))
  (loop [i :down-to [(- n 1) 0] :let [w (* 9 (weight (letters i)))]]
    (put low i (+ (low (+ i 1)) (min w 0)))
    (put high i (+ (high (+ i 1)) (max w 0))))
  (def digits @{})
  (def used @{})
  (defn search [i total]
    (cond
      (= i n) (zero? total)
      (not (<= (low i) (- total) (high i))) false
      (let [letter (letters i)]
        (some (fn [d]
                (unless (or (used d) (and (zero? d) (leading letter)))
                  (put used d true)
                  (put digits letter d)
                  (or (search (+ i 1) (+ total (* d (weight letter))))
                      (do (put used d nil) false))))
              (range 10)))))
  (when (search 0 0)
    (table/to-struct (tabseq [[letter d] :pairs digits] (string/from-bytes letter) d))))
