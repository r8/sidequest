# Each row is "<home team>;<away team>;<result>", the result being win, loss or draw for the home team.

(def- outcomes
  {"win" [:w :l]
   "loss" [:l :w]
   "draw" [:d :d]})

(defn- line [& cells]
  (string/format "%-30s | %2s | %2s | %2s | %2s | %2s" ;(map string cells)))

(defn tally
  "(tally rows) -> an array of the lines of the league table for the match rows"
  [rows]
  (def results  # [team outcome] pairs, two per match
    (mapcat (fn [row]
              (def [home away result] (string/split ";" row))
              (def [home-outcome away-outcome] (outcomes result))
              [[home home-outcome] [away away-outcome]])
            rows))
  (def standings
    (seq [[team team-results] :pairs (group-by first results)
          :let [counts (frequencies (map last team-results))
                [w d l] (map |(get counts $ 0) [:w :d :l])]]
      [team (+ w d l) w d l (+ (* 3 w) d)]))
  (sort-by (fn [[team _ _ _ _ points]] [(- points) team]) standings)  # most points, then by name
  [(line "Team" "MP" "W" "D" "L" "P") ;(map |(line ;$) standings)])
