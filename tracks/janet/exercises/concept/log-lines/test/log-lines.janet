(import test :as t)
(import ../log-lines :as sol)

(def log
  (string/join ["[INFO] 06:45 tram 12: depot exit"
                "[WARN] 14:02 tram 7: door sensor stuck"
                "[INFO] 14:05 switch 31: set to left"
                "[ERROR] 14:09 tram 7: emergency brake"
                "[ERROR] 14:30 tram 2: power lost"]
               "\n"))

(t/deftest "1. a warning"
  (t/assert-equal :warn (sol/level "[WARN] 14:02 tram 7: door sensor stuck")))

(t/deftest "1. info and error"
  (t/assert-equal [:info :error] [(sol/level "[INFO] 06:45 ok") (sol/level "[ERROR] 06:50 tram 4: power lost")]))

(t/deftest "1. no brackets"
  (t/assert-equal nil (sol/level "WARN: no brackets")))

(t/deftest "1. an unknown level"
  (t/assert-equal nil (sol/level "[DEBUG] 06:45 tram 12: hello")))

(t/deftest "1. the level must start the line"
  (t/assert-equal nil (sol/level " [INFO] 06:45 indented")))

(t/deftest "2. a morning time"
  (t/assert-equal [6 45] (sol/timestamp "[INFO] 06:45 tram 12: depot exit")))

(t/deftest "2. an afternoon time"
  (t/assert-equal [14 2] (sol/timestamp "[WARN] 14:02 tram 7: door sensor stuck")))

(t/deftest "2. midnight after an error"
  (t/assert-equal [0 0] (sol/timestamp "[ERROR] 00:00 clock reset")))

(t/deftest "3. the trams of a log"
  (t/assert-equal ["12" "7" "7" "2"] (sol/trams log)))

(t/deftest "3. a line with two trams"
  (t/assert-equal ["5" "18"] (sol/trams "[INFO] 08:00 tram 5 passed tram 18")))

(t/deftest "3. no trams"
  (t/assert-equal [] (sol/trams "[INFO] 14:05 switch 31: set to left")))

(t/deftest "4. one badge"
  (t/assert-equal "[INFO] 07:10 tram 3: driver badge [redacted] on duty"
                  (sol/redact "[INFO] 07:10 tram 3: driver badge 4471 on duty")))

(t/deftest "4. two badges"
  (t/assert-equal "[INFO] 19:00 tram 3: badge [redacted] hands over to badge [redacted]"
                  (sol/redact "[INFO] 19:00 tram 3: badge 4471 hands over to badge 902")))

(t/deftest "4. nothing to redact"
  (t/assert-equal "[WARN] 14:02 tram 7: door sensor stuck" (sol/redact "[WARN] 14:02 tram 7: door sensor stuck")))

(t/deftest "4. the result is a string"
  (t/assert-true (string? (sol/redact "badge 1")) "expected redact to return a string"))

(t/deftest "5. the first error in a log"
  (t/assert-equal 108 (sol/first-error log)))

(t/deftest "5. an error on the first line"
  (t/assert-equal 0 (sol/first-error "[ERROR] 06:50 tram 4: power lost")))

(t/deftest "5. no errors"
  (t/assert-equal nil (sol/first-error "[INFO] 06:45 ok\n[WARN] 06:46 hmm")))

(t/run)
