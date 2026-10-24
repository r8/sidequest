(import test :as t)
(import ../leaderboard :as sol)

(def ines {:name "Ines" :score 212})
(def al {:name "Al" :score 190})
(def ruth {:name "Ruth" :score 150})
(def bo {:name "Bo" :score 88})

(t/deftest "1. scores from highest to lowest"
  (t/assert-equal [212 180 97] (sol/ranked-scores [180 212 97])))

(t/deftest "1. a single score"
  (t/assert-equal [42] (sol/ranked-scores [42])))

(t/deftest "1. an empty board"
  (t/assert-equal [] (sol/ranked-scores [])))

(t/deftest "1. the scores passed in are not changed"
  (def scores @[97 212 180])
  (sol/ranked-scores scores)
  (t/assert-equal [97 212 180] scores))

(t/deftest "2. players in alphabetical order"
  (t/assert-equal [al ines ruth] (sol/by-name [ruth al ines])))

(t/deftest "2. names already in order stay in order"
  (t/assert-equal [al bo] (sol/by-name [al bo])))

(t/deftest "2. the players passed in are not changed"
  (def players @[ruth al])
  (sol/by-name players)
  (t/assert-equal [ruth al] players))

(t/deftest "3. the best three of four"
  (t/assert-equal ["Ines" "Al" "Ruth"] (sol/podium [ruth al ines bo])))

(t/deftest "3. exactly three players"
  (t/assert-equal ["Al" "Ruth" "Bo"] (sol/podium [bo ruth al])))

(t/deftest "3. fewer than three players"
  (t/assert-equal ["Ines" "Bo"] (sol/podium [bo ines])))

(t/deftest "3. nobody has played yet"
  (t/assert-equal [] (sol/podium [])))

(t/deftest "4. sorts the board by score, best first"
  (def board @[bo ines ruth al])
  (sol/rank! board)
  (t/assert-equal [ines al ruth bo] board))

(t/deftest "4. returns the same array it was given"
  (def board @[bo ines])
  (t/assert-true (= board (sol/rank! board)) "expected rank! to return the board itself"))

(t/deftest "4. equal scores are ordered by name"
  (def board @[{:name "Bo" :score 150} {:name "Cy" :score 99} {:name "Al" :score 150} ines])
  (sol/rank! board)
  (t/assert-equal [ines {:name "Al" :score 150} {:name "Bo" :score 150} {:name "Cy" :score 99}] board))

(t/run)
